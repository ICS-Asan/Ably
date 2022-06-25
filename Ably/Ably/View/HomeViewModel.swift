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
    var goods: [AblyGoods] = []
    
    func transform(_ input: Input) -> Output {
        input
            .loadDataObserver
            .subscribe(onNext: { [weak self] data in
                self?.storeFetchedAblyHomeData(homeData: data)
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
    
    func toggleFavoriteState(at index: Int) {
        self.goods[index].isFavorite.toggle()
    }
}

extension HomeViewModel {
    final class Input {
        let loadDataObserver: Observable<AblyHomeData>
        let refreshObserver: Observable<AblyHomeData>
        let didTabFavoriteButton: Observable<Int>

        init(
            loadFinishedObserver: Observable<AblyHomeData>,
            refreshObserver: Observable<AblyHomeData>,
            didTabFavoriteButton: Observable<Int>
        ) {
            self.loadDataObserver = loadFinishedObserver
            self.refreshObserver = refreshObserver
            self.didTabFavoriteButton = didTabFavoriteButton
        }
    }

    final class Output { }

}
