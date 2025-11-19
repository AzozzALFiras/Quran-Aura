import SwiftUI

struct HomeView: View {
    let reciters: [Reciter]
    let surahs: [Surah]
    @ObservedObject var audioPlayer: AudioPlayer
    @ObservedObject var appData: AppData
    @Binding var showingFullPlayer: Bool
    @Binding var selectedTab: Int
    
    var featuredReciters: [Reciter] {
        Array(reciters.prefix(6))
    }
    
    var recentSurahs: [Surah] {
        Array(surahs.prefix(8))
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(getGreeting())
                        .font(.title2)
                        .foregroundColor(.white.opacity(0.8))
                    
                    Text("القرآن الكريم")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .padding(.horizontal)
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 12) {
                    QuickActionCard(
                        title: "استمر في الاستماع",
                        subtitle: "آخر سورة",
                        icon: "play.circle.fill",
                        color: .purple,
                        action: {
                            if let recent = appData.recentPlays.first {
                                audioPlayer.playSurah(recent.surah, for: recent.reciter)
                                showingFullPlayer = true
                            }
                        }
                    )
                    
                    QuickActionCard(
                        title: "السور المفضلة",
                        subtitle: "\(appData.favoriteSurahs.count) سورة",
                        icon: "heart.fill",
                        color: .pink,
                        action: {
                            selectedTab = 1
                        }
                    )
                    
                    QuickActionCard(
                        title: "التلاوات الأخيرة",
                        subtitle: "\(appData.recentPlays.count) تلاوة",
                        icon: "clock.fill",
                        color: .orange,
                        action: {}
                    )
                    
                    QuickActionCard(
                        title: "القراء المفضلون",
                        subtitle: "\(appData.favoriteReciters.count) قارئ",
                        icon: "person.2.fill",
                        color: .blue,
                        action: {
                            selectedTab = 2
                        }
                    )
                }
                .padding(.horizontal)
                
                if !appData.recentPlays.isEmpty {
                    VStack(alignment: .leading, spacing: 15) {
                        HStack {
                            Text("المستمع إليه حديثاً")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Button("عرض الكل") {}
                                .font(.caption)
                                .foregroundColor(.purple)
                        }
                        
                        LazyVStack(spacing: 8) {
                            ForEach(appData.recentPlays.prefix(3)) { recent in
                                RecentPlayRow(recent: recent, audioPlayer: audioPlayer, showingFullPlayer: $showingFullPlayer)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                VStack(alignment: .leading, spacing: 15) {
                    Text("القراء المميزون")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 15) {
                            ForEach(featuredReciters) { reciter in
                                Button {
                                    selectedTab = 2
                                } label: {
                                    ReciterCard(reciter: reciter, appData: appData)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                
                VStack(alignment: .leading, spacing: 15) {
                    Text("السور الأخيرة")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    LazyVStack(spacing: 8) {
                        ForEach(recentSurahs) { surah in
                            SurahRow(
                                surah: surah,
                                audioPlayer: audioPlayer,
                                appData: appData,
                                showingFullPlayer: $showingFullPlayer
                            )
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .background(Color(.systemBackground))
        .navigationBarHidden(true)
        .alert("خطأ في التشغيل", isPresented: .constant(audioPlayer.errorMessage != nil)) {
            Button("حسناً", role: .cancel) {
                audioPlayer.errorMessage = nil
            }
        } message: {
            if let error = audioPlayer.errorMessage {
                Text(error)
            }
        }
    }
    
    private func getGreeting() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 5..<12: return "صباح الخير"
        case 12..<18: return "مساء الخير"
        default: return "مساء الخير"
        }
    }
}