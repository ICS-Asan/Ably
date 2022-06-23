import Foundation
import RxSwift

class AblyHomeDataUseCase {
    let ablyHomeDataRepository: AblyAPIRepository
    
    init(ablyHomeDataRepository: AblyAPIRepository = AblyHomeDataRepository()) {
        self.ablyHomeDataRepository = ablyHomeDataRepository
    }
    
    func fetchAblyHomeData() -> Observable<AblyHomeData> {
        return ablyHomeDataRepository.fetchAblyHomeData()
    }
    
    func fetchAblyGoodsForPaging(with lastId: Int) -> Observable<AblyHomeData> {
        return ablyHomeDataRepository.fetchAblyGoodsForPaging(with: lastId)
    }
}
