import Foundation

struct Dua: Identifiable, Codable, Equatable {
    let id: Int
    let categoryId: String
    let title: String
    let text: String
    let longExplanation: String?
    let audioFile: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case categoryId = "category_id"
        case title
        case text
        case longExplanation = "long_explanation"
        case audioFile = "audio_file"
    }
    
    static func == (lhs: Dua, rhs: Dua) -> Bool {
        lhs.id == rhs.id
    }
}
