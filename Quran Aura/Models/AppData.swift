import SwiftUI
import Combine

class AppData: ObservableObject {
    @Published var favoriteSurahs: [Surah] = [] {
        didSet { saveFavorites() }
    }
    @Published var favoriteReciters: [Reciter] = [] {
        didSet { saveFavorites() }
    }
    @Published var recentPlays: [RecentPlay] = [] {
        didSet { saveRecentPlays() }
    }
    @Published var settings: AppSettings = AppSettings() {
        didSet { saveSettings() }
    }
    
    private let favoritesKey = "favorites"
    private let recentPlaysKey = "recentPlays"
    private let settingsKey = "appSettings"
    
    init() {
        loadFavorites()
        loadRecentPlays()
        loadSettings()
    }
    
    private func loadFavorites() {
        if let data = UserDefaults.standard.data(forKey: favoritesKey) {
            let decoder = JSONDecoder()
            if let favorites = try? decoder.decode(FavoritesData.self, from: data) {
                self.favoriteSurahs = favorites.surahs
                self.favoriteReciters = favorites.reciters
            }
        }
    }
    
    private func saveFavorites() {
        let favorites = FavoritesData(surahs: favoriteSurahs, reciters: favoriteReciters)
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(favorites) {
            UserDefaults.standard.set(data, forKey: favoritesKey)
        }
    }
    
    private func loadRecentPlays() {
        if let data = UserDefaults.standard.data(forKey: recentPlaysKey) {
            let decoder = JSONDecoder()
            if let recentPlays = try? decoder.decode([RecentPlay].self, from: data) {
                self.recentPlays = recentPlays
            }
        }
    }
    
    private func saveRecentPlays() {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(recentPlays) {
            UserDefaults.standard.set(data, forKey: recentPlaysKey)
        }
    }
    
    private func loadSettings() {
        if let data = UserDefaults.standard.data(forKey: settingsKey) {
            let decoder = JSONDecoder()
            if let settings = try? decoder.decode(AppSettings.self, from: data) {
                self.settings = settings
            }
        }
    }
    
    private func saveSettings() {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(settings) {
            UserDefaults.standard.set(data, forKey: settingsKey)
        }
    }
}

struct FavoritesData: Codable {
    let surahs: [Surah]
    let reciters: [Reciter]
}