import Foundation

struct Surah: Identifiable, Codable, Equatable {
    let id = UUID()
    let name: String
    let number: String
    
    var formattedNumber: String {
        String(format: "%03d", Int(number) ?? 0)
    }
    
    static func == (lhs: Surah, rhs: Surah) -> Bool {
        lhs.id == rhs.id && lhs.name == rhs.name && lhs.number == rhs.number
    }
}

struct SurahsResponse: Codable {
    let status: Int
    let success: Bool
    let message: String
    let info: String
    let data: [String: String]
}