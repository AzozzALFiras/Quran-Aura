import SwiftUI

extension Double {
    func formatTime() -> String {
        let minutes = Int(self) / 60
        let seconds = Int(self) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}

extension String {
    var secureImage: String {
        return self.replacingOccurrences(of: "http://", with: "https://")
    }
}

extension View {
    func withCardStyle() -> some View {
        self
            .padding()
            .background(AppConfig.shared.cardBackground)
            .cornerRadius(12)
    }
    
    func withGradientBackground() -> some View {
        self.background(AppConfig.shared.primaryGradient)
    }
}
