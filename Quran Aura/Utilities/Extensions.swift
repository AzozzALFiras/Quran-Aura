import Foundation

extension Double {
    func formatTime() -> String {
        guard self.isFinite && !self.isNaN else { return "0:00" }
        let minutes = Int(self) / 60
        let seconds = Int(self) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}