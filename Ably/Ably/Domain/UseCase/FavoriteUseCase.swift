import Foundation
import RxSwift

final class FavoriteUseCase {
    let realmRepository: RealmRepository
    
    init(realmRepository: RealmRepository = AblyRealmRepository()) {
        self.realmRepository = realmRepository
    }
    
    func fetchRealmData() -> Observable<[AblyGoods]>{
        return realmRepository.fetchRealmData()
    }
}
