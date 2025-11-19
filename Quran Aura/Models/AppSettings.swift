import Foundation

struct AppSettings: Codable {
    var notificationsEnabled: Bool = true
    var darkModeEnabled: Bool = true
    var selectedTheme: Int = 0
    var playbackQuality: Int = 1
    var autoPlayNext: Bool = true
}