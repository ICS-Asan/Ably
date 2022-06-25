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
    
    
    
    func fetchAblyHomeData() -> Observable<AblyHomeData> {
        return homeDataUseCase.fetchAblyHomeData()
    }
    
    func storeFetchedData(homeData: AblyHomeData) {
        self.homeData = homeData
        self.banners = homeData.banners ?? []
        self.goods = homeData.goods
    }
}
