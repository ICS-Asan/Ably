import Foundation

struct AblyHomeDTO: Codable {
    let banners: [AblyBannerDTO]?
    let goods: [AblyGoodsDTO]
    
    func toDomain() -> AblyHomeData {
        let transferedBanners = banners?.map{ $0.toDomain() }
        let transferedGoods = goods.map { $0.toDomain() }
        return AblyHomeData(banners: transferedBanners, goods: transferedGoods)
    }
}
