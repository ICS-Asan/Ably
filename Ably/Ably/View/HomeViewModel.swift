import Foundation
import RxSwift

protocol ViewModelDescribing {
    associatedtype Input
    associatedtype Output
    
    func transform(_ input: Input) -> Output
}

class HomeViewModel {
    private let homeDataUseCase = AblyHomeDataUseCase()
    private let disposeBag: DisposeBag = .init()
    private var homeData = AblyHomeData(banners: [], goods: [])
    private(set) var banners: [AblyBanner] = []
    private(set) var goods: [AblyGoods] = []
    private(set) var favoriteGoods: [AblyGoods] = []
 
    func transform(_ input: Input) -> Output {
        input
            .loadViewObserver
            .subscribe(onNext: { [weak self] data in
                self?.favoriteGoods = data
            })
            .disposed(by: disposeBag)
        input
            .loadDataObserver
            .subscribe(onNext: { [weak self] data in
                self?.storeFetchedAblyHomeData(homeData: data)
                self?.applyFavoriteState()
            })
            .disposed(by: disposeBag)
        input
            .refreshObserver
            .subscribe(onNext: { [weak self] data in
                self?.refreshAblyHomeData(homeData: data)
            })
            .disposed(by: disposeBag)
        input
            .didTabFavoriteButton
            .subscribe(onNext: { [weak self] index in
                self?.toggleFavoriteState(at: index)
            })
            .disposed(by: disposeBag)
        
        return Output()
    }
    
    func fetchAblyHomeData() -> Observable<AblyHomeData> {
        return homeDataUseCase.fetchAblyHomeData()
    }
    
    func fetchRealmData() -> Observable<[AblyGoods]>{
        return homeDataUseCase.fetchRealmData()
    }
    
    func fetchAblyGoodsForPagination() -> Observable<AblyHomeData> {
        return homeDataUseCase.fetchAblyGoodsForPagination(with: goods.last?.id ?? 1)
    }
    
    func refreshAblyHomeData(homeData: AblyHomeData) {
        self.homeData = homeData
        self.banners = homeData.banners ?? []
        self.goods = homeData.goods
    }
    
    func storeFetchedAblyHomeData(homeData: AblyHomeData) {
        self.homeData = homeData
        self.banners += (homeData.banners ?? [])
        self.goods += homeData.goods
    }
    
    func applyFavoriteState() {
        favoriteGoods.forEach { favorite in
            let index = goods.firstIndex(where: { $0.id  == favorite.id })
            changeFavoriteState(at: index)
        }
    }
    
    func changeFavoriteState(at index: Int?) {
        guard let index = index else { return }
        goods[index].isFavorite = true
    }
    
    func toggleFavoriteState(at index: Int) {
        let currentFavoriteState = self.goods[index].isFavorite
        if currentFavoriteState == true {
            self.goods[index].isFavorite = false
            homeDataUseCase.deleteFromRealm(ablyGoods: self.goods[index])
        } else {
            self.goods[index].isFavorite = true
            homeDataUseCase.appendToRealm(ablyGoods: self.goods[index])
        }
    }
}

extension HomeViewModel {
    final class Input {
        let loadViewObserver: Observable<[AblyGoods]>
        let loadDataObserver: Observable<AblyHomeData>
        let refreshObserver: Observable<AblyHomeData>
        let didTabFavoriteButton: Observable<Int>

        init(
            loadViewObserver: Observable<[AblyGoods]>,
            loadFinishedObserver: Observable<AblyHomeData>,
            refreshObserver: Observable<AblyHomeData>,
            didTabFavoriteButton: Observable<Int>
        ) {
            self.loadViewObserver = loadViewObserver
            self.loadDataObserver = loadFinishedObserver
            self.refreshObserver = refreshObserver
            self.didTabFavoriteButton = didTabFavoriteButton
        }
    }

    final class Output { }

}
