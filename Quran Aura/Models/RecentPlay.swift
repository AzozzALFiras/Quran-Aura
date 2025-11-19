import Foundation

struct RecentPlay: Identifiable, Equatable, Codable {
    let id = UUID()
    let surah: Surah
    let reciter: Reciter
    let date: Date
    
    static func == (lhs: RecentPlay, rhs: RecentPlay) -> Bool {
        lhs.id == rhs.id
    }
}