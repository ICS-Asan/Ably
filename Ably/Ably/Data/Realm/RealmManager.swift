import Foundation
import RxSwift
import RealmSwift

class RealmManager {
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
}
