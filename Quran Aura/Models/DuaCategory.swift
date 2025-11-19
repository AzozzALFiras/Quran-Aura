import Foundation

struct DuaCategory: Identifiable, Codable, Equatable {
    let id: String
    let name: String
    let nameEn: String
    let count: Int
    var prayers: [Dua]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case nameEn = "name_en"
        case count
        case prayers
    }
    
    static func == (lhs: DuaCategory, rhs: DuaCategory) -> Bool {
        lhs.id == rhs.id
    }
}

struct DuasResponse: Codable {
    let status: Int
    let success: Bool
    let message: String
    let timestamp: String
    let data: DuasData
}

struct DuasData: Codable {
    let totalCategories: Int
    let totalPrayers: Int
    let categories: [DuaCategory]
    
    enum CodingKeys: String, CodingKey {
        case totalCategories = "total_categories"
        case totalPrayers = "total_prayers"
        case categories
    }
}
