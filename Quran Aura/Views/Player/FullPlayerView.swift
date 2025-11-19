import SwiftUI

struct FullPlayerView: View {
    @ObservedObject var audioPlayer: AudioPlayer
    @ObservedObject var appData: AppData
    @Binding var showingFullPlayer: Bool
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
           LinearGradient(
        gradient: Gradient(colors: [
            Color(red: 10/255, green: 25/255, blue: 70/255),   // أزرق داكن
            Color(red: 55/255, green: 15/255, blue: 90/255)    // بنفسجي غامق
        ]),
        startPoint: .top,
        endPoint: .bottom
    )
            .ignoresSafeArea()
            
            VStack(spacing: 40) {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                        showingFullPlayer = false
                    }) {
                        Image(systemName: "chevron.down")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 4) {
                        Text("الآن يُشغل")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.7))
                        
                        if let surah = audioPlayer.currentSurah {
                            Text(surah.name)
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                    }
                    
                    Spacer()
                    
                    Menu {
                        if let surah = audioPlayer.currentSurah {
                            Button {
                                toggleFavorite(surah: surah)
                            } label: {
                                Label(
                                    isFavorite(surah: surah) ? "إزالة من المفضلة" : "إضافة إلى المفضلة",
                                    systemImage: isFavorite(surah: surah) ? "heart.slash" : "heart"
                                )
                            }
                            
                            Button {
                                shareCurrentSurah()
                            } label: {
                                Label("مشاركة", systemImage: "square.and.arrow.up")
                            }
                        }
                        
                        Button(role: .destructive) {
                            audioPlayer.stop()
                            showingFullPlayer = false
                        } label: {
                            Label("إيقاف", systemImage: "stop.circle")
                        }
                    } label: {
                        Image(systemName: "ellipsis")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal)
                
                ZStack {
                    Circle()
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [.purple, .blue]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .frame(width: 280, height: 280)
                        .shadow(color: .purple.opacity(0.3), radius: 20)
                    
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
                            .foregroundColor(.white)
                    }
                }
                
                VStack(spacing: 8) {
                    if let surah = audioPlayer.currentSurah {
                        Text(surah.name)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    
                    if let reciter = audioPlayer.currentReciter {
                        Text(reciter.name)
                            .font(.body)
                            .foregroundColor(.white.opacity(0.8))
                    }
                }
                
                VStack(spacing: 8) {
                    HStack {
                        Text(audioPlayer.currentTime.formatTime())
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.7))
                        
                        Spacer()
                        
                        Text(audioPlayer.duration.formatTime())
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.7))
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
                    .accentColor(.purple)
                }
                .padding(.horizontal)
                
                VStack(spacing: 30) {
                    HStack(spacing: 40) {
                        Button(action: {}) {
                            Image(systemName: "shuffle")
                                .font(.title3)
                                .foregroundColor(.white.opacity(0.7))
                        }
                        
                        Button(action: {}) {
                            Image(systemName: "repeat")
                                .font(.title3)
                                .foregroundColor(.white.opacity(0.7))
                        }
                        
                        if let surah = audioPlayer.currentSurah {
                            Button {
                                toggleFavorite(surah: surah)
                            } label: {
                                Image(systemName: isFavorite(surah: surah) ? "heart.fill" : "heart")
                                    .font(.title3)
                                    .foregroundColor(isFavorite(surah: surah) ? .red : .white.opacity(0.7))
                            }
                        }
                        
                        Button(action: {}) {
                            Image(systemName: "speaker.wave.2")
                                .font(.title3)
                                .foregroundColor(.white.opacity(0.7))
                        }
                    }
                    
                    HStack(spacing: 40) {
                        Button(action: audioPlayer.skipBackward) {
                            Image(systemName: "gobackward.15")
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                        
                        Button(action: audioPlayer.playPause) {
                            ZStack {
                                Circle()
                                    .fill(Color.purple)
                                    .frame(width: 70, height: 70)
                                
                                Image(systemName: audioPlayer.isPlaying ? "pause.fill" : "play.fill")
                                    .font(.title2)
                                    .foregroundColor(.white)
                            }
                        }
                        
                        Button(action: audioPlayer.skipForward) {
                            Image(systemName: "goforward.15")
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                    }
                }
                
                Spacer()
            }
            .padding(.top, 50)
        }
        .preferredColorScheme(.dark)
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
    
    private func shareCurrentSurah() {
        if let surah = audioPlayer.currentSurah, let reciter = audioPlayer.currentReciter {
            let shareText = "أستمع الآن إلى سورة \(surah.name) بصوت القارئ \(reciter.name) في تطبيق Quran Aura"
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