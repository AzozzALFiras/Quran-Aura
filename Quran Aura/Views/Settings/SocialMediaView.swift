import SwiftUI

struct SocialMediaView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("تابعنا على")
                .font(.headline)
                .foregroundColor(.white)
            
            HStack(spacing: 20) {
                SocialMediaButton(
                    platform: "Twitter",
                    icon: "bird",
                    color: .blue,
                    url: "https://twitter.com/quranaura"
                )
                
                SocialMediaButton(
                    platform: "Instagram",
                    icon: "camera",
                    color: .pink,
                    url: "https://instagram.com/quranaura"
                )
                
                SocialMediaButton(
                    platform: "TikTok",
                    icon: "music.note",
                    color: .black,
                    url: "https://tiktok.com/@quranaura"
                )
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
    }
}