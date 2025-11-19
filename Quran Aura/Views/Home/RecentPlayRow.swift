import SwiftUI

struct RecentPlayRow: View {
    let recent: RecentPlay
    @ObservedObject var audioPlayer: AudioPlayer
    @Binding var showingFullPlayer: Bool
    
    var body: some View {
        HStack {
            Text(recent.surah.formattedNumber)
                .font(.caption)
                .foregroundColor(AppConfig.shared.textPrimary)
                .frame(width: 30, height: 30)
                .background(Circle().fill(Color.appPrimary))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(recent.surah.name)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(AppConfig.shared.textPrimary)
                
                Text(recent.reciter.name)
                    .font(.caption)
                    .foregroundColor(AppConfig.shared.textSecondary)
            }
            
            Spacer()
            
            Button {
                audioPlayer.playSurah(recent.surah, for: recent.reciter)
                showingFullPlayer = true
            } label: {
                Image(systemName: "play.circle.fill")
                    .font(.title2)
                    .foregroundColor(.appPrimary)
            }
        }
        .padding()
        .background(AppConfig.shared.cardBackground)
        .cornerRadius(8)
    }
}