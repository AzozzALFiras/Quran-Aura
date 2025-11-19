import SwiftUI

struct SettingsView: View {
    @ObservedObject var appData: AppData
    @State private var showingAbout = false
    
    let themes = ["أرجواني", "أزرق", "أخضر", "برتقالي"]
    let qualities = ["عالية", "متوسطة", "منخفضة"]
    
    var body: some View {
        Form {
            Section(header: Text("المظهر")) {
                Toggle("الوضع الليلي", isOn: $appData.settings.darkModeEnabled)
                
                Picker("لون التطبيق", selection: $appData.settings.selectedTheme) {
                    ForEach(0..<themes.count, id: \.self) { index in
                        Text(themes[index]).tag(index)
                    }
                }
            }
            
            Section(header: Text("التشغيل")) {
                Picker("جودة التشغيل", selection: $appData.settings.playbackQuality) {
                    ForEach(0..<qualities.count, id: \.self) { index in
                        Text(qualities[index]).tag(index)
                    }
                }
                
                Toggle("التشغيل التلقائي", isOn: $appData.settings.autoPlayNext)
            }
            
            Section(header: Text("وسائل التواصل الاجتماعي")) {
                SocialMediaView()
            }
            
            Section(header: Text("تواصل معنا")) {
                Button("البريد الإلكتروني") {
                    sendEmail()
                }
                
                Button("الموقع الإلكتروني") {
                    openWebsite()
                }
            }
            
            Section(header: Text("عام")) {
                Toggle("الإشعارات", isOn: $appData.settings.notificationsEnabled)
                
                Button("حول التطبيق") {
                    showingAbout = true
                }
                
                Button("مشاركة التطبيق") {
                    shareApp()
                }
            }
            
            Section(header: Text("المطور")) {
                HStack {
                    Text("الإصدار")
                    Spacer()
                    Text("1.0.0")
                        .foregroundColor(.gray)
                }
                
                HStack {
                    Text("البريد الإلكتروني")
                    Spacer()
                    Text("dev@quranaura.com")
                        .foregroundColor(.gray)
                }
                
                HStack {
                    Text("الموقع")
                    Spacer()
                    Text("quranaura.com")
                        .foregroundColor(.gray)
                }
            }
            
            Section {
                Text("© 2025 Quran Aura. جميع الحقوق محفوظة.")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .navigationTitle("الإعدادات")
        .preferredColorScheme(appData.settings.darkModeEnabled ? .dark : .light)
        .sheet(isPresented: $showingAbout) {
            AboutView()
        }
    }
    
    private func shareApp() {
        let shareText = "تطبيق Quran Aura - استمع إلى القرآن الكريم"
        let activityVC = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            rootViewController.present(activityVC, animated: true)
        }
    }
    
    private func sendEmail() {
        let email = "support@quranaura.com"
        if let url = URL(string: "mailto:\(email)") {
            UIApplication.shared.open(url)
        }
    }
    
    private func openWebsite() {
        if let url = URL(string: "https://quranaura.com") {
            UIApplication.shared.open(url)
        }
    }
}