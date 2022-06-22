import Foundation

struct AblyGoodsDTO: Codable {
    let id: Int
    let name: String
    let image: String
    let isNew: Bool
    let sellCount, actualPrice, price: Int

    enum CodingKeys: String, CodingKey {
        case id, name, image
        case isNew = "is_new"
        case sellCount = "sell_count"
        case actualPrice = "actual_price"
        case price
    }
}
