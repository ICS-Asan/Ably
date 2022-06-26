import Foundation
import RxSwift

class AblyHomeDataUseCase {
    let ablyHomeDataRepository: AblyAPIRepository
    let realmRepository: RealmRepository
    
    init(
        ablyHomeDataRepository: AblyAPIRepository = AblyHomeDataRepository(),
        realmRepository: RealmRepository = RealmRepository()
    ) {
        self.ablyHomeDataRepository = ablyHomeDataRepository
        self.realmRepository = realmRepository
    }
    
    func fetchAblyHomeData() -> Observable<AblyHomeData> {
        return ablyHomeDataRepository.fetchAblyHomeData()
    }
    
    func fetchAblyGoodsForPagination(with lastId: Int) -> Observable<AblyHomeData> {
        return ablyHomeDataRepository.fetchAblyGoodsForPaging(with: lastId)
    }
    
    func fetchRealmData() -> Observable<[AblyGoods]> {
        return realmRepository.fetchRealmData()
    }
    
    func appendToRealm(ablyGoods: AblyGoods) {
        realmRepository.append(ablyGoods: ablyGoods)
    }
    
    func deleteFromRealm(ablyGoods: AblyGoods) {
        realmRepository.delete(ablyGoods: ablyGoods)
    }
}
