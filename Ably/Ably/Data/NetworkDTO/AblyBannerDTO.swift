import Foundation

struct AblyBannerDTO: Codable {
    let id: Int
    let image: String
    
    func toDomain() -> AblyBanner {
        return AblyBanner(id: id, image: image)
    }
}
