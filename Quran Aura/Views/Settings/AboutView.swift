import SwiftUI

struct AboutView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Image(systemName: "book.circle.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.appPrimary)
                    
                    Text(AppConfig.shared.appName)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(AppConfig.shared.textPrimary)
                    
                    Text("تطبيق \(AppConfig.shared.appName) هو تطبيق مجاني للاستماع إلى القرآن الكريم بأصوات أشهر القراء. تم تطويره بحب ❤️ لتسهيل الوصول إلى كلام الله تعالى.")
                        .multilineTextAlignment(.center)
                        .foregroundColor(AppConfig.shared.textSecondary)
                        .padding()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        FeatureRow(icon: "headphones", title: "استماع مجاني", subtitle: "استمع إلى القرآن كاملاً بدون اتصال بالإنترنت")
                        FeatureRow(icon: "person.2.fill", title: "أشهر القراء", subtitle: "مجموعة مختارة من أفضل القراء في العالم")
                        FeatureRow(icon: "heart.fill", title: "المفضلة", subtitle: "احفظ السور والقراء المفضلين لديك")
                        FeatureRow(icon: "moon.fill", title: "وضع ليلي", subtitle: "تجربة مريحة للعين في الإضاءة المنخفضة")
                    }
                    .padding()
                    
                    Text("\(AppConfig.shared.strings.version) \(AppConfig.shared.appVersion)")
                        .font(.caption)
                        .foregroundColor(AppConfig.shared.textSecondary)
                }
                .padding()
            }
            .background(AppConfig.shared.primaryGradient)
            .navigationTitle(AppConfig.shared.strings.aboutApp)
            .navigationBarItems(trailing: Button(AppConfig.shared.strings.done) {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct FeatureRow: View {
    let icon: String
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.appPrimary)
                .frame(width: 40)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(AppConfig.shared.textPrimary)
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(AppConfig.shared.textSecondary)
            }
            
            Spacer()
        }
    }
}