import SwiftUI

struct ReciterCard: View {
    let reciter: Reciter
    @ObservedObject var appData: AppData
    
    var body: some View {
        VStack {
            ZStack(alignment: .topTrailing) {
                RemoteImage(
                    url: reciter.secureImage,
                    placeholder: "person.circle.fill",
                    width: 80,
                    height: 80,
                    cornerRadius: 40
                )
                
                Button {
                    toggleFavorite(reciter: reciter)
                } label: {
                    Image(systemName: isFavorite(reciter: reciter) ? "heart.fill" : "heart")
                        .font(.caption)
                        .foregroundColor(isFavorite(reciter: reciter) ? .red : .white)
                        .padding(6)
                        .background(Color(.systemBackground))
                        .clipShape(Circle())
                }
            }
            
            Text(reciter.name)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .lineLimit(2)
        }
        .frame(width: 100)
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
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