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
}

extension HomeViewModel {
    final class Input {
        let loadDataObserver: Observable<AblyHomeData>
        let refreshObserver: Observable<AblyHomeData>

        init(loadFinishedObserver: Observable<AblyHomeData>, refreshObserver: Observable<AblyHomeData>) {
            self.loadDataObserver = loadFinishedObserver
            self.refreshObserver = refreshObserver
        }
    }

    final class Output { }

}
