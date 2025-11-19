import Foundation

struct Reciter: Identifiable, Codable, Equatable {
    let id = UUID()
    let name: String
    let href: String
    let image: String?
    
    enum CodingKeys: String, CodingKey {
        case name, href, image
    }
    
    static func == (lhs: Reciter, rhs: Reciter) -> Bool {
        lhs.id == rhs.id && lhs.name == rhs.name && lhs.href == rhs.href
    }
    
    var secureHref: String {
        if href.hasPrefix("http://") {
            return href.replacingOccurrences(of: "http://", with: "https://")
        }
        return href
    }
    
    var secureImage: String? {
        guard let image = image else { return nil }
        if image.hasPrefix("http://") {
            return image.replacingOccurrences(of: "http://", with: "https://")
        }
        return image
    }
}

struct RecitersResponse: Codable {
    let status: Int
    let success: Bool
    let message: String
    let info: String
    let data: [Reciter]
}