import SwiftUI

struct SocialMediaButton: View {
    let platform: String
    let icon: String
    let color: Color
    let url: String
    
    var body: some View {
        Button(action: {
            openSocialMedia(url: url)
        }) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50)
                    .background(color)
                    .clipShape(Circle())
                
                Text(platform)
                    .font(.caption)
                    .foregroundColor(.white)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private func openSocialMedia(url: String) {
        guard let url = URL(string: url) else { return }
        UIApplication.shared.open(url)
    }
}