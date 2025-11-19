import SwiftUI

struct ContentView: View {
    @StateObject private var audioPlayer = AudioPlayer()
    @StateObject private var appData = AppData()
    @State private var selectedTab = 0
    @State private var reciters: [Reciter] = []
    @State private var surahs: [Surah] = []
    @State private var isLoading = true
    @State private var errorMessage: String?
    @State private var showingMiniPlayer = false
    @State private var showingFullPlayer = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Main App Content
            VStack(spacing: 0) {
                TabView(selection: $selectedTab) {
                    // Home Tab
                    NavigationView {
                        HomeView(
                            reciters: reciters,
                            surahs: surahs,
                            audioPlayer: audioPlayer,
                            appData: appData,
                            showingFullPlayer: $showingFullPlayer,
                            selectedTab: $selectedTab
                        )
                    }
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("الرئيسية")
                    }
                    .tag(0)
                    
                    // Search Tab
                    NavigationView {
                        SearchView(
                            reciters: reciters,
                            surahs: surahs,
                            audioPlayer: audioPlayer,
                            appData: appData,
                            showingFullPlayer: $showingFullPlayer
                        )
                    }
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("بحث")
                    }
                    .tag(1)
                    
                    // Reciters Tab
                    NavigationView {
                        RecitersListView(
                            reciters: reciters,
                            audioPlayer: audioPlayer,
                            appData: appData,
                            showingFullPlayer: $showingFullPlayer
                        )
                    }
                    .tabItem {
                        Image(systemName: "person.2.fill")
                        Text("المقرئون")
                    }
                    .tag(2)
                    
                    // Surahs Tab
                    NavigationView {
                        SurahsListView(
                            surahs: surahs,
                            audioPlayer: audioPlayer,
                            appData: appData,
                            showingFullPlayer: $showingFullPlayer
                        )
                    }
                    .tabItem {
                        Image(systemName: "book.fill")
                        Text("السور")
                    }
                    .tag(3)
                    
                    // Settings Tab
                    NavigationView {
                        SettingsView(appData: appData)
                    }
                    .tabItem {
                        Image(systemName: "gearshape.fill")
                        Text("الإعدادات")
                    }
                    .tag(4)
                }
                .accentColor(getThemeColor())
                .preferredColorScheme(appData.settings.darkModeEnabled ? .dark : .light)
            }
            
            // Mini Player - Appears above TabView
if showingMiniPlayer && audioPlayer.currentSurah != nil && !showingFullPlayer {
    MiniPlayerView(audioPlayer: audioPlayer)
        .frame(height: 100) // Increase the height of MiniPlayer
        .onTapGesture {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                showingFullPlayer = true
            }
        }
        .transition(.move(edge: .bottom))
        .zIndex(1)
        .padding(.bottom, 60) // Raise MiniPlayer higher above the bottom
}

            
            // Full Player Overlay - Appears above everything
            if showingFullPlayer {
                FullPlayerView(
                    audioPlayer: audioPlayer,
                    appData: appData,
                    showingFullPlayer: $showingFullPlayer
                )
                .transition(.opacity.combined(with: .scale(scale: 0.95)))
                .zIndex(2) // Higher than MiniPlayer and TabView
            }
        }
        .ignoresSafeArea(.keyboard)
        .overlay {
            if isLoading {
                LoadingView()
            } else if let error = errorMessage {
                ErrorView(error: error, retryAction: loadData)
            }
        }
        .onAppear {
            loadData()
        }
        .onChange(of: audioPlayer.currentSurah) { surah in
            withAnimation(.spring()) {
                showingMiniPlayer = surah != nil
            }
            
            if let surah = surah, let reciter = audioPlayer.currentReciter {
                let recentPlay = RecentPlay(surah: surah, reciter: reciter, date: Date())
                appData.recentPlays.removeAll { $0.surah.id == surah.id && $0.reciter.id == reciter.id }
                appData.recentPlays.insert(recentPlay, at: 0)
                if appData.recentPlays.count > 10 {
                    appData.recentPlays = Array(appData.recentPlays.prefix(10))
                }
            }
        }
        .onChange(of: audioPlayer.isPlaying) { isPlaying in
            if !isPlaying && audioPlayer.currentSurah == nil {
                withAnimation(.spring()) {
                    showingMiniPlayer = false
                }
            }
        }
        .environment(\.layoutDirection, .rightToLeft)
    }
    
    private func loadData() {
        isLoading = true
        errorMessage = nil
        
        let group = DispatchGroup()
        
        group.enter()
        NetworkService.shared.fetchReciters { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let reciters):
                    self.reciters = reciters
                case .failure(let error):
                    self.errorMessage = "Failed to load reciters: \(error.localizedDescription)"
                }
                group.leave()
            }
        }
        
        group.enter()
        NetworkService.shared.fetchSurahs { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let surahs):
                    self.surahs = surahs
                case .failure(let error):
                    if self.errorMessage == nil {
                        self.errorMessage = "Failed to load surahs: \(error.localizedDescription)"
                    }
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.isLoading = false
        }
    }
    
    private func getThemeColor() -> Color {
        switch appData.settings.selectedTheme {
        case 0: return .purple
        case 1: return .blue
        case 2: return .green
        case 3: return .orange
        default: return .purple
        }
    }
}