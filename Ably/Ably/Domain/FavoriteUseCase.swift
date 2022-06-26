import Foundation
import RxSwift

final class FavoriteUseCase {
    let realmRepository: RealmRepository
    
    init(realmRepository: RealmRepository = RealmRepository()) {
        self.realmRepository = realmRepository
    }
    
    func fetchRealmData() -> Observable<[AblyGoods]>{
        return realmRepository.fetchRealmData()
    }
}
