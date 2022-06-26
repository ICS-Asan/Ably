import Foundation
import RxSwift

class FavoriteViewModel {
    private let favoriteUseCase = FavoriteUseCase()
    private let disposeBag: DisposeBag = .init()

    func fetchFavoriteGoods() -> Observable<[AblyGoods]>{
        return favoriteUseCase.fetchRealmData()
    }
}
