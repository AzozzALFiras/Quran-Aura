import SwiftUI

struct MiniPlayerView: View {
    @ObservedObject var audioPlayer: AudioPlayer
    
    var body: some View {
        VStack(spacing: 0) {
            ProgressBar(value: $audioPlayer.currentTime, range: 0...audioPlayer.duration)
                .frame(height: 2)
            
            HStack {
                if let surah = audioPlayer.currentSurah {
                    if let reciter = audioPlayer.currentReciter {
                        RemoteImage(
                            url: reciter.secureImage,
                            placeholder: "book.circle.fill",
                            width: 40,
                            height: 40,
                            cornerRadius: 6
                        )
                    } else {
                        Image(systemName: "book.circle.fill")
                            .font(.title2)
                            .foregroundColor(.purple)
                    }
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(surah.name)
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                        
                        if let reciter = audioPlayer.currentReciter {
                            Text(reciter.name)
                                .font(.caption2)
                                .foregroundColor(.white.opacity(0.7))
                        }
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 20) {
                        Button(action: audioPlayer.skipBackward) {
                            Image(systemName: "gobackward.15")
                                .font(.body)
                                .foregroundColor(.white)
                        }
                        
                        Button(action: audioPlayer.playPause) {
                            Image(systemName: audioPlayer.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                        
                        Button(action: audioPlayer.skipForward) {
                            Image(systemName: "goforward.15")
                                .font(.body)
                                .foregroundColor(.white)
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(Color(.secondarySystemBackground))
        }
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
}