import SwiftUI

struct SettingsView: View {
    @ObservedObject var appData: AppData
    @State private var showingAbout = false
    
    let themes = ["أرجواني", "أزرق", "أخضر", "برتقالي"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text(AppConfig.shared.strings.appearance).foregroundColor(.appPrimary)) {
                    Toggle(AppConfig.shared.strings.darkMode, isOn: $appData.settings.darkModeEnabled)
                    
                    Picker(AppConfig.shared.strings.appTheme, selection: $appData.settings.selectedTheme) {
                        ForEach(0..<themes.count, id: \.self) { index in
                            Text(themes[index]).tag(index)
                        }
                    }
                }
                
                Section(header: Text(AppConfig.shared.strings.socialMedia).foregroundColor(.appPrimary)) {
                    SocialMediaView()
                }
                
                Section(header: Text("عام").foregroundColor(.appPrimary)) {
                    Button(AppConfig.shared.strings.aboutApp) {
                        showingAbout = true
                    }
                    .foregroundColor(AppConfig.shared.textPrimary)
                    
                    Button(AppConfig.shared.strings.shareApp) {
                        shareApp()
                    }
                    .foregroundColor(AppConfig.shared.textPrimary)
                }
                
                Section(header: Text(AppConfig.shared.strings.developer).foregroundColor(.appPrimary)) {
                    HStack {
                        Text(AppConfig.shared.strings.version)
                        Spacer()
                        Text(AppConfig.shared.appVersion)
                            .foregroundColor(AppConfig.shared.textSecondary)
                    }
                    
                    HStack {
                        Text(AppConfig.shared.strings.email)
                        Spacer()
                        Text(AppConfig.shared.developerEmail)
                            .foregroundColor(AppConfig.shared.textSecondary)
                    }
                    
                    HStack {
                        Text(AppConfig.shared.strings.website)
                        Spacer()
                        Text(AppConfig.shared.website)
                            .foregroundColor(AppConfig.shared.textSecondary)
                    }
                }
                
                Section {
                    Text("© 2025 \(AppConfig.shared.appName). جميع الحقوق محفوظة.")
                        .font(.caption)
                        .foregroundColor(AppConfig.shared.textSecondary)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .background(AppConfig.shared.primaryGradient)
            .navigationTitle(AppConfig.shared.strings.settings)
            .preferredColorScheme(appData.settings.darkModeEnabled ? .dark : .light)
            .sheet(isPresented: $showingAbout) {
                AboutView()
            }
        }
    }
    
    private func shareApp() {
        let shareText = "تطبيق \(AppConfig.shared.appName) - استمع إلى القرآن الكريم"
        let activityVC = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            rootViewController.present(activityVC, animated: true)
        }
    }
}