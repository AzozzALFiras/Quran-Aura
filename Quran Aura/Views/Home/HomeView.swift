import SwiftUI

struct HomeView: View {
    let reciters: [Reciter]
    let surahs: [Surah]
    @ObservedObject var audioPlayer: AudioPlayer
    @ObservedObject var appData: AppData
    @Binding var showingFullPlayer: Bool
    @Binding var selectedTab: Int
    
    @State private var showingSettings = false
    
    var featuredReciters: [Reciter] {
        Array(reciters.prefix(6))
    }
    
    var recentSurahs: [Surah] {
        Array(surahs.prefix(8))
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 20) {
                // Header with Settings Icon
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(getGreeting())
                            .font(.title2)
                            .foregroundColor(AppConfig.shared.textSecondary)
                        
                        Text(AppConfig.shared.strings.quran)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(AppConfig.shared.textPrimary)
                    }
                    
                    Spacer()
                    
                    // Settings Button
                    Button(action: {
                        showingSettings = true
                    }) {
                        Image(systemName: "gearshape.fill")
                            .font(.title2)
                            .foregroundColor(AppConfig.shared.textPrimary)
                            .padding(8)
                            .background(Color.white.opacity(0.2))
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal)
                
                // Quick Actions Grid
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 12) {
                    QuickActionCard(
                        title: AppConfig.shared.strings.continueListening,
                        subtitle: AppConfig.shared.strings.lastSurah,
                        icon: "play.circle.fill",
                        color: .appPrimary,
                        action: {
                            if let recent = appData.recentPlays.first {
                                audioPlayer.playSurah(recent.surah, for: recent.reciter)
                                showingFullPlayer = true
                            }
                        }
                    )
                    
                    QuickActionCard(
                        title: AppConfig.shared.strings.favoriteSurahs,
                        subtitle: "\(appData.favoriteSurahs.count) سورة",
                        icon: "heart.fill",
                        color: .appAccent,
                        action: {
                            selectedTab = 1
                        }
                    )
                    
                    QuickActionCard(
                        title: AppConfig.shared.strings.recentRecitations,
                        subtitle: "\(appData.recentPlays.count) تلاوة",
                        icon: "clock.fill",
                        color: .orange,
                        action: {}
                    )
                    
                    QuickActionCard(
                        title: AppConfig.shared.strings.favoriteReciters,
                        subtitle: "\(appData.favoriteReciters.count) قارئ",
                        icon: "person.2.fill",
                        color: .appSecondary,
                        action: {
                            selectedTab = 2
                        }
                    )
                }
                .padding(.horizontal)
                
                // Recent Plays Section
                if !appData.recentPlays.isEmpty {
                    VStack(alignment: .leading, spacing: 15) {
                        HStack {
                            Text(AppConfig.shared.strings.recentlyListened)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(AppConfig.shared.textPrimary)
                            
                            Spacer()
                            
                            Button(AppConfig.shared.strings.viewAll) {}
                                .font(.caption)
                                .foregroundColor(.appPrimary)
                        }
                        
                        LazyVStack(spacing: 8) {
                            ForEach(appData.recentPlays.prefix(3)) { recent in
                                RecentPlayRow(recent: recent, audioPlayer: audioPlayer, showingFullPlayer: $showingFullPlayer)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Featured Reciters Section
                VStack(alignment: .leading, spacing: 15) {
                    Text(AppConfig.shared.strings.featuredReciters)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(AppConfig.shared.textPrimary)
                    
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
                
                // Recent Surahs Section
                VStack(alignment: .leading, spacing: 15) {
                    Text(AppConfig.shared.strings.recentSurahs)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(AppConfig.shared.textPrimary)
                    
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
        .background(AppConfig.shared.primaryGradient)
        .navigationBarHidden(true)
        .sheet(isPresented: $showingSettings) {
            SettingsView(appData: appData)
        }
        .alert(AppConfig.shared.strings.playbackError, isPresented: .constant(audioPlayer.errorMessage != nil)) {
            Button(AppConfig.shared.strings.ok, role: .cancel) {
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
        case 5..<12: return AppConfig.shared.strings.goodMorning
        case 12..<18: return AppConfig.shared.strings.goodEvening
        default: return AppConfig.shared.strings.goodEvening
        }
    }
}