import SwiftUI

struct ReciterRow: View {
    let reciter: Reciter
    @ObservedObject var appData: AppData
    
    var body: some View {
        HStack {
            RemoteImage(
                url: reciter.secureImage,
                placeholder: "person.circle.fill",
                width: 50,
                height: 50,
                cornerRadius: 25
            )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(reciter.name)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(AppConfig.shared.textPrimary)
                
                Text("114 سورة")
                    .font(.caption)
                    .foregroundColor(AppConfig.shared.textSecondary)
            }
            
            Spacer()
            
            Button {
                toggleFavorite(reciter: reciter)
            } label: {
                Image(systemName: isFavorite(reciter: reciter) ? "heart.fill" : "heart")
                    .foregroundColor(isFavorite(reciter: reciter) ? .red : AppConfig.shared.textPrimary)
            }
            
            Image(systemName: "play.circle")
                .font(.caption)
                .foregroundColor(.appPrimary)
        }
        .padding(.vertical, 8)
        .background(AppConfig.shared.cardBackground)
    }
    
    private func isFavorite(reciter: Reciter) -> Bool {
        appData.favoriteReciters.contains { $0.id == reciter.id }
    }
    
    private func toggleFavorite(reciter: Reciter) {
        if let index = appData.favoriteReciters.firstIndex(where: { $0.id == reciter.id }) {
            appData.favoriteReciters.remove(at: index)
        } else {
            appData.favoriteReciters.append(reciter)
        }
    }
}