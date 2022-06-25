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
            .loadFinishedObserver
            .subscribe(onNext: { [weak self] data in
                self?.storeFetchedData(homeData: data)
            })
            .disposed(by: disposeBag)
        
        return Output()
    }
    
    func fetchAblyHomeData() -> Observable<AblyHomeData> {
        return homeDataUseCase.fetchAblyHomeData()
    }
    
    func storeFetchedData(homeData: AblyHomeData) {
        self.homeData = homeData
        self.banners = homeData.banners ?? []
        self.goods = homeData.goods
    }
}

extension HomeViewModel {
    final class Input {
        let loadFinishedObserver: Observable<AblyHomeData>

        init(loadFinishedObserver: Observable<AblyHomeData>) {
            self.loadFinishedObserver = loadFinishedObserver
        }
    }

    final class Output { }

}
