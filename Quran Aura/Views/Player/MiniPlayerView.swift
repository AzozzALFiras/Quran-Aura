import SwiftUI

struct MiniPlayerView: View {
    @ObservedObject var audioPlayer: AudioPlayer
    
    var body: some View {
        VStack(spacing: 0) {
            // Animated Progress bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.white.opacity(0.3))
                        .frame(height: 3)
                    
                    Rectangle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [.white, .white.opacity(0.8)]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: geometry.size.width * CGFloat(audioPlayer.currentTime / max(audioPlayer.duration, 1)), height: 3)
                }
            }
            .frame(height: 3)
            
            HStack(spacing: 12) {
                if let surah = audioPlayer.currentSurah {
                    // Album Art with rotation animation
                    ZStack {
                        if let reciter = audioPlayer.currentReciter {
                            RemoteImage(
                                url: reciter.secureImage,
                                placeholder: "music.note",
                                width: 50,
                                height: 50,
                                cornerRadius: 8
                            )
                        } else {
                            Image(systemName: "music.note")
                                .font(.title2)
                                .foregroundColor(AppConfig.shared.textPrimary)
                                .frame(width: 50, height: 50)
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [.appPrimary, .appSecondary]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .cornerRadius(8)
                        }
                    }
                    .rotationEffect(.degrees(audioPlayer.isPlaying ? 360 : 0))
                    .animation(audioPlayer.isPlaying ? 
                        Animation.linear(duration: 8).repeatForever(autoreverses: false) : .default,
                        value: audioPlayer.isPlaying
                    )
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(surah.name)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(AppConfig.shared.textPrimary)
                            .lineLimit(1)
                        
                        if let reciter = audioPlayer.currentReciter {
                            Text(reciter.name)
                                .font(.caption)
                                .foregroundColor(AppConfig.shared.textSecondary)
                                .lineLimit(1)
                        }
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 20) {
                        Button(action: audioPlayer.skipBackward) {
                            Image(systemName: "gobackward.15")
                                .font(.body)
                                .foregroundColor(AppConfig.shared.textPrimary)
                        }
                        
                        Button(action: audioPlayer.playPause) {
                            Image(systemName: audioPlayer.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                                .font(.title2)
                                .foregroundColor(AppConfig.shared.textPrimary)
                        }
                        
                        Button(action: audioPlayer.skipForward) {
                            Image(systemName: "goforward.15")
                                .font(.body)
                                .foregroundColor(AppConfig.shared.textPrimary)
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.appPrimary.opacity(0.9),
                        Color.appSecondary.opacity(0.8)
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(16)
            .padding(.horizontal, 16)
            .padding(.bottom, 8)
            .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
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
}