import Foundation
import RxSwift
import RealmSwift

class AblyRealmRepository: RealmRepository {
    
    func fetchRealmData() -> Observable<[AblyGoods]> {
        return RealmManager.shared.fetch()
    }

    func append(ablyGoods: AblyGoods) {
        RealmManager.shared.append(ablyGoods: ablyGoods)
    }
    
    func delete(ablyGoods: AblyGoods) {
        RealmManager.shared.delete(ablyGoods: ablyGoods)
    }
}
