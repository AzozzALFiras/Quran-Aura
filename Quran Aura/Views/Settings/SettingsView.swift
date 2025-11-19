// SettingsView.swift
import SwiftUI

struct SettingsView: View {
    @ObservedObject var appData: AppData
    @State private var showingAbout = false
    
    let themes = ["أرجواني", "أزرق", "أخضر", "برتقالي"]
    
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
            
            Section(header: Text("وسائل التواصل الاجتماعي")) {
                SocialMediaView()
            }
            
            Section(header: Text("عام")) {
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
}
