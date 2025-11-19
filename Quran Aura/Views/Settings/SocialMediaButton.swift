// SocialMediaButton.swift
import SwiftUI

struct SocialMediaButton: View {
    let platform: String
    let iconName: String
    let color: Color
    let url: String
    
    var body: some View {
        Button(action: {
            openSocialMedia(url: url)
        }) {
            VStack(spacing: 8) {
                Image(iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 65, height: 65)
                    .foregroundColor(.white)
                    .frame(width: 70, height: 70)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                    .shadow(color: color.opacity(0.5), radius: 8, x: 0, y: 4)
                
                Text(platform)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private func openSocialMedia(url: String) {
        guard let url = URL(string: url) else { return }
        UIApplication.shared.open(url)
    }
}
