import Foundation
import RealmSwift

final class AblyGoodsRealmDTO: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var price: Int = 0
    @objc dynamic var actualPrice: Int = 0
    @objc dynamic var sellCount: Int = 0
    @objc dynamic var discountRate: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var isNew: Bool = false
    @objc dynamic var isFavorite: Bool = false
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(
        id: Int,
        price: Int,
        actualPrice: Int,
        sellCount: Int,
        discountRate: Int,
        name: String,
        image: String,
        isNew: Bool,
        isFavorite: Bool
    ) {
        self.init()
        self.id = id
        self.price = price
        self.actualPrice = actualPrice
        self.sellCount = sellCount
        self.discountRate = discountRate
        self.name = name
        self.image = image
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

