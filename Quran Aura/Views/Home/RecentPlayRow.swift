import SwiftUI

struct RecentPlayRow: View {
    let recent: RecentPlay
    @ObservedObject var audioPlayer: AudioPlayer
    @Binding var showingFullPlayer: Bool
    
    var body: some View {
        HStack {
            Text(recent.surah.formattedNumber)
                .font(.caption)
                .foregroundColor(.white)
                .frame(width: 30, height: 30)
                .background(Circle().fill(Color.purple))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(recent.surah.name)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                
                Text(recent.reciter.name)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.7))
            }
            
            Spacer()
            
            Button {
                audioPlayer.playSurah(recent.surah, for: recent.reciter)
                showingFullPlayer = true
            } label: {
                Image(systemName: "play.circle.fill")
                    .font(.title2)
                    .foregroundColor(.purple)
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(8)
    }
}