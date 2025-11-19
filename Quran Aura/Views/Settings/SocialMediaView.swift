import SwiftUI

struct SocialMediaView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text(AppConfig.shared.strings.followUs)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(AppConfig.shared.textPrimary)
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 20) {
                SocialMediaButton(
                    platform: "X",
                    iconName: "x_icon",
                    color: .black,
                    url: AppConfig.shared.socialMedia.xTwitter
                )
                
                SocialMediaButton(
                    platform: "انستغرام",
                    iconName: "instagram_icon",
                    color: Color(red: 0.86, green: 0.28, blue: 0.53),
                    url: AppConfig.shared.socialMedia.instagram
                )
                
                SocialMediaButton(
                    platform: "تيك توك",
                    iconName: "tiktok_icon",
                    color: .black,
                    url: AppConfig.shared.socialMedia.tiktok
                )
                
                SocialMediaButton(
                    platform: "سناب شات",
                    iconName: "snapchat_icon",
                    color: .yellow,
                    url: AppConfig.shared.socialMedia.snapchat
                )
                
                SocialMediaButton(
                    platform: "قت هاب",
                    iconName: "github_icon",
                    color: .black,
                    url: AppConfig.shared.socialMedia.github
                )
            }
        }
        .padding(20)
        .padding(.horizontal)
    }
}

struct SocialMediaView_Previews: PreviewProvider {
    static var previews: some View {
        SocialMediaView()
            .background(AppConfig.shared.primaryGradient)
            .preferredColorScheme(.dark)
    }
}