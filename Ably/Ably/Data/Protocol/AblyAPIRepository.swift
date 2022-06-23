import Foundation
import RxSwift

protocol AblyAPIRepository {
    func fetchAblyHomeData() -> Observable<AblyHomeData>
    func fetchAblyGoodsForPaging(with lastId: Int) -> Observable<AblyHomeData>
}
