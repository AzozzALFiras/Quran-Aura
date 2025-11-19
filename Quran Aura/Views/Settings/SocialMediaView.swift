// SocialMediaView.swift
import SwiftUI

struct SocialMediaView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("تابعنا على")
                .font(.title3)
                .fontWeight(.bold)
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 20) {
                SocialMediaButton(
                    platform: "X",
                    iconName: "x_icon",
                    color: .black,
                    url: "https://x.com/dev_3zozz"
                )
                
                SocialMediaButton(
                    platform: "انستغرام",
                    iconName: "instagram_icon",
                    color: Color(red: 0.86, green: 0.28, blue: 0.53),
                    url: "https://instagram.com/dev_3zozz"
                )
                
                SocialMediaButton(
                    platform: "تيك توك",
                    iconName: "tiktok_icon",
                    color: .black,
                    url: "https://tiktok.com/@dev_3zozz"
                )
                
                SocialMediaButton(
                    platform: "سناب شات",
                    iconName: "snapchat_icon",
                    color: .yellow,
                    url: "https://snapchat.com/add/n.uf"
                )
                SocialMediaButton(
                    platform: "قت هاب",
                    iconName: "github_icon",
                    color: .black,
                    url: "https://github.com/azozzalfiras"
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
            .preferredColorScheme(.dark)
    }
}
