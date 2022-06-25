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
    
    func fetchAblyHomeData() -> Observable<AblyHomeData> {
        return homeDataUseCase.fetchAblyHomeData()
    }
}
