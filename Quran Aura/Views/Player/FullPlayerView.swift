import SwiftUI

struct FullPlayerView: View {
    @ObservedObject var audioPlayer: AudioPlayer
    @ObservedObject var appData: AppData
    @Binding var showingFullPlayer: Bool
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            AppConfig.shared.playerGradient
                .ignoresSafeArea()
            
            VStack(spacing: 40) {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                        showingFullPlayer = false
                    }) {
                        Image(systemName: "chevron.down")
                            .font(.title2)
                            .foregroundColor(AppConfig.shared.textPrimary)
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 4) {
                        Text(AppConfig.shared.strings.nowPlaying)
                            .font(.caption)
                            .foregroundColor(AppConfig.shared.textSecondary)
                        
                        if let surah = audioPlayer.currentSurah {
                            Text(surah.name)
                                .font(.headline)
                                .foregroundColor(AppConfig.shared.textPrimary)
                        }
                    }
                    
                    Spacer()
                    
                    Menu {
                        if let surah = audioPlayer.currentSurah {
                            Button {
                                toggleFavorite(surah: surah)
                            } label: {
                                Label(
                                    isFavorite(surah: surah) ? AppConfig.shared.strings.removeFromFavorites : AppConfig.shared.strings.addToFavorites,
                                    systemImage: isFavorite(surah: surah) ? "heart.slash" : "heart"
                                )
                            }
                            
                            Button {
                                shareCurrentSurah()
                            } label: {
                                Label(AppConfig.shared.strings.share, systemImage: "square.and.arrow.up")
                            }
                        }
                        
                        Button(role: .destructive) {
                            audioPlayer.stop()
                            showingFullPlayer = false
                        } label: {
                            Label(AppConfig.shared.strings.stop, systemImage: "stop.circle")
                        }
                    } label: {
                        Image(systemName: "ellipsis")
                            .font(.title2)
                            .foregroundColor(AppConfig.shared.textPrimary)
                    }
                }
                .padding(.horizontal)
                
                ZStack {
                    Circle()
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [.appPrimary, .appSecondary]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .frame(width: 280, height: 280)
                        .shadow(color: .appPrimary.opacity(0.3), radius: 20)
                    
                    if let reciter = audioPlayer.currentReciter {
                        RemoteImage(
                            url: reciter.secureImage,
                            placeholder: "book.circle.fill",
                            width: 200,
                            height: 200,
                            cornerRadius: 100
                        )
                    } else {
                        Image(systemName: "book.circle.fill")
                            .font(.system(size: 120))
                            .foregroundColor(AppConfig.shared.textPrimary)
                    }
                }
                
                VStack(spacing: 8) {
                    if let surah = audioPlayer.currentSurah {
                        Text(surah.name)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(AppConfig.shared.textPrimary)
                    }
                    
                    if let reciter = audioPlayer.currentReciter {
                        Text(reciter.name)
                            .font(.body)
                            .foregroundColor(AppConfig.shared.textSecondary)
                    }
                }
                
                VStack(spacing: 8) {
                    HStack {
                        Text(audioPlayer.currentTime.formatTime())
                            .font(.caption)
                            .foregroundColor(AppConfig.shared.textSecondary)
                        
                        Spacer()
                        
                        Text(audioPlayer.duration.formatTime())
                            .font(.caption)
                            .foregroundColor(AppConfig.shared.textSecondary)
                    }
                    
                    Slider(
                        value: $audioPlayer.currentTime,
                        in: 0...max(audioPlayer.duration, 1),
                        onEditingChanged: { editing in
                            audioPlayer.isSeeking = editing
                            if !editing {
                                audioPlayer.seek(to: audioPlayer.currentTime)
                            }
                        }
                    )
                    .accentColor(.appPrimary)
                }
                .padding(.horizontal)
                
                VStack(spacing: 30) {
                    HStack(spacing: 40) {
                        Button(action: {}) {
                            Image(systemName: "shuffle")
                                .font(.title3)
                                .foregroundColor(AppConfig.shared.textSecondary)
                        }
                        
                        Button(action: {}) {
                            Image(systemName: "repeat")
                                .font(.title3)
                                .foregroundColor(AppConfig.shared.textSecondary)
                        }
                        
                        if let surah = audioPlayer.currentSurah {
                            Button {
                                toggleFavorite(surah: surah)
                            } label: {
                                Image(systemName: isFavorite(surah: surah) ? "heart.fill" : "heart")
                                    .font(.title3)
                                    .foregroundColor(isFavorite(surah: surah) ? .red : AppConfig.shared.textSecondary)
                            }
                        }
                        
                        Button(action: {}) {
                            Image(systemName: "speaker.wave.2")
                                .font(.title3)
                                .foregroundColor(AppConfig.shared.textSecondary)
                        }
                    }
                    
                    HStack(spacing: 40) {
                        Button(action: audioPlayer.skipBackward) {
                            Image(systemName: "gobackward.15")
                                .font(.title2)
                                .foregroundColor(AppConfig.shared.textPrimary)
                        }
                        
                        Button(action: audioPlayer.playPause) {
                            ZStack {
                                Circle()
                                    .fill(Color.appPrimary)
                                    .frame(width: 70, height: 70)
                                
                                Image(systemName: audioPlayer.isPlaying ? "pause.fill" : "play.fill")
                                    .font(.title2)
                                    .foregroundColor(AppConfig.shared.textPrimary)
                            }
                        }
                        
                        Button(action: audioPlayer.skipForward) {
                            Image(systemName: "goforward.15")
                                .font(.title2)
                                .foregroundColor(AppConfig.shared.textPrimary)
                        }
                    }
                }
                
                Spacer()
            }
            .padding(.top, 50)
        }
        .preferredColorScheme(.dark)
        .navigationBarHidden(true)
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
    
    private func shareCurrentSurah() {
        if let surah = audioPlayer.currentSurah, let reciter = audioPlayer.currentReciter {
            let shareText = "أستمع الآن إلى سورة \(surah.name) بصوت القارئ \(reciter.name) في تطبيق \(AppConfig.shared.appName)"
            let activityVC = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let rootViewController = windowScene.windows.first?.rootViewController {
                rootViewController.present(activityVC, animated: true)
            }
        }
    }
    
    private func isFavorite(surah: Surah) -> Bool {
        appData.favoriteSurahs.contains { $0.id == surah.id }
    }
    
    private func toggleFavorite(surah: Surah) {
        if let index = appData.favoriteSurahs.firstIndex(where: { $0.id == surah.id }) {
            appData.favoriteSurahs.remove(at: index)
        } else {
            appData.favoriteSurahs.append(surah)
        }
    }
}