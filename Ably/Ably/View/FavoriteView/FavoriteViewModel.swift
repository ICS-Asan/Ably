import Foundation
import RxSwift

final class FavoriteViewModel {
    private let favoriteUseCase = FavoriteUseCase()
    private let disposeBag: DisposeBag = .init()

    func fetchFavoriteGoods() -> Observable<[AblyGoods]>{
        return favoriteUseCase.fetchRealmData()
    }
}
