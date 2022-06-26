import Foundation
import RxSwift

protocol RealmRepository {
    
    func fetchRealmData() -> Observable<[AblyGoods]>

    func append(ablyGoods: AblyGoods)
    
    func delete(ablyGoods: AblyGoods) 
}
