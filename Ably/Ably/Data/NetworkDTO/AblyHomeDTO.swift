import Foundation

struct AblyHomeDTO: Codable {
    let banners: [AblyBannerDTO]?
    let goods: [AblyGoodsDTO]
}
