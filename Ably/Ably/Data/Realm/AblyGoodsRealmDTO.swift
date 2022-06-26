import Foundation
import RealmSwift

final class AblyGoodsRealmDTO: Object {
    @objc dynamic var id: Int
    @objc dynamic var price: Int
    @objc dynamic var actualPrice: Int
    @objc dynamic var sellCount: Int
    @objc dynamic var discountRate: Int
    @objc dynamic var name: String
    @objc dynamic var image: String
    @objc dynamic var isNew: Bool
    @objc dynamic var isFavorite: Bool
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    init(
        id: Int,
        price: Int,
        actualPrice: Int,
        sellCount: Int,
        discountRate: Int,
        name: String,
        imageURL: String,
        isNew: Bool,
        isFavorite: Bool
    )
    {
        self.id = id
        self.price = price
        self.actualPrice = actualPrice
        self.sellCount = sellCount
        self.discountRate = discountRate
        self.name = name
        self.image = imageURL
        self.isNew = isNew
        self.isFavorite = isFavorite
    }
}

extension AblyGoodsRealmDTO {
    func toDomain() -> AblyGoods {
        return AblyGoods(
            id: id,
            name: name,
            image: image,
            isNew: isNew,
            sellCount: sellCount,
            actualPrice: actualPrice,
            price: price,
            isFavorite: isFavorite
        )
    }
}

