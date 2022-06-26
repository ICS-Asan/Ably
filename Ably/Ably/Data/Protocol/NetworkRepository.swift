import Foundation
import RxSwift

protocol NetworkRepository {
    func fetchAblyHomeData() -> Observable<AblyHomeData>
    func fetchAblyGoodsForPaging(with lastId: Int) -> Observable<AblyHomeData>
}
