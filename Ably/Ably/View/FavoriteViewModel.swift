import Foundation
import RxSwift

class FavoriteViewModel {
    private let favoriteUseCase = FavoriteUseCase()
    private let disposeBag: DisposeBag = .init()
 
//    func transform(_ input: Input) -> Output {
//        input
//            .loadViewObserver
//            .subscribe(onNext: { [weak self] data in
//                self?.favoriteGoods = data
//            })
//            .disposed(by: disposeBag)
//        input
//            .loadDataObserver
//            .subscribe(onNext: { [weak self] data in
//                self?.storeFetchedAblyHomeData(homeData: data)
//                self?.applyFavoriteState()
//            })
//            .disposed(by: disposeBag)
//        input
//            .refreshObserver
//            .subscribe(onNext: { [weak self] data in
//                self?.refreshAblyHomeData(homeData: data)
//            })
//            .disposed(by: disposeBag)
//        input
//            .didTabFavoriteButton
//            .subscribe(onNext: { [weak self] index in
//                self?.toggleFavoriteState(at: index)
//            })
//            .disposed(by: disposeBag)
//
//        return Output()
//    }
    func fetchFavoriteGoods() -> Observable<[AblyGoods]>{
        return favoriteUseCase.fetchRealmData()
    }
}

//extension HomeViewModel {
//    final class Input {
//        let loadViewObserver: Observable<[AblyGoods]>
//        let loadDataObserver: Observable<AblyHomeData>
//        let refreshObserver: Observable<AblyHomeData>
//        let didTabFavoriteButton: Observable<Int>
//
//        init(
//            loadViewObserver: Observable<[AblyGoods]>,
//            loadFinishedObserver: Observable<AblyHomeData>,
//            refreshObserver: Observable<AblyHomeData>,
//            didTabFavoriteButton: Observable<Int>
//        ) {
//            self.loadViewObserver = loadViewObserver
//            self.loadDataObserver = loadFinishedObserver
//            self.refreshObserver = refreshObserver
//            self.didTabFavoriteButton = didTabFavoriteButton
//        }
//    }
//
//    final class Output { }
//
//}
