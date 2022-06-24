import Foundation

struct AblyGoods {
    let id: Int
    let name: String
    let image: String
    let isNew: Bool
    let sellCount: Int
    let actualPrice: Int
    let price: Int
    
    var discountPriceRate: Int {
        let decimalActualPrice = Decimal(actualPrice)
        let decimalDiscountPrice = decimalActualPrice - Decimal(price)
        let discountRate = Double(truncating: decimalDiscountPrice/decimalActualPrice as NSNumber)
        return Int(discountRate * 100)
    }
}
