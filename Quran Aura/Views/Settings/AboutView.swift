// AboutView.swift
import SwiftUI

struct AboutView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Image(systemName: "book.circle.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.purple)
                    
                    Text("Quran Aura")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("تطبيق Quran Aura هو تطبيق مجاني للاستماع إلى القرآن الكريم بأصوات أشهر القراء. تم تطويره بحب ❤️ لتسهيل الوصول إلى كلام الله تعالى.")
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        FeatureRow(icon: "headphones", title: "استماع مجاني", subtitle: "استمع إلى القرآن كاملاً بدون اتصال بالإنترنت")
                        FeatureRow(icon: "person.2.fill", title: "أشهر القراء", subtitle: "مجموعة مختارة من أفضل القراء في العالم")
                        FeatureRow(icon: "heart.fill", title: "المفضلة", subtitle: "احفظ السور والقراء المفضلين لديك")
                        FeatureRow(icon: "moon.fill", title: "وضع ليلي", subtitle: "تجربة مريحة للعين في الإضاءة المنخفضة")
                    }
                    .padding()
                    
                    Text("نسخة 1.0.0")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding()
            }
            .navigationTitle("حول التطبيق")
            .navigationBarItems(trailing: Button("تم") {
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
                .foregroundColor(.purple)
                .frame(width: 40)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
    }
}
