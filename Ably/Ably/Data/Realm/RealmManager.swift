import Foundation
import RxSwift
import RealmSwift

final class RealmManager {
    static let shared = RealmManager()
    let realm = try! Realm()
    
    init() {}
    
    func fetch() -> Observable<[AblyGoods]> {
        return Observable.create { [weak self] emitter in
            var ablyGoods: [AblyGoods] = []
            self?.realm.objects(AblyGoodsRealmDTO.self).forEach { realmData in
                let fetchedGoods = realmData.toDomain()
                
                ablyGoods.append(fetchedGoods)
            }
            emitter.onNext(ablyGoods)
            emitter.onCompleted()
            
            return Disposables.create()
        }
    }
    
    func append(ablyGoods: AblyGoods) {
        let favoriteGoods = AblyGoodsRealmDTO(
            id: ablyGoods.id,
            price: ablyGoods.price,
            actualPrice: ablyGoods.actualPrice,
            sellCount: ablyGoods.sellCount,
            discountRate: ablyGoods.discountPriceRate,
            name: ablyGoods.name,
            image: ablyGoods.image,
            isNew: ablyGoods.isNew,
            isFavorite: ablyGoods.isFavorite)
        
        try! self.realm.write{
            self.realm.add(favoriteGoods)
        }
    }
    
    func delete(ablyGoods: AblyGoods) {
        let goodsForDelete = realm.objects(AblyGoodsRealmDTO.self).filter("id == %@", ablyGoods.id)
        
        try! self.realm.write{
            self.realm.delete(goodsForDelete)
        }
    }
}
