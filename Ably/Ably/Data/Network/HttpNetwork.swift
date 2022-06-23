import Foundation
import RxSwift

class HttpNetwork {
    static let shared = HttpNetwork()
    let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    private func fetch(with endPoint: URL?) -> Observable<Data> {
        guard let endPoint = endPoint else {
            // 유효하지 않은 URL Error 추가
            return .error(fatalError())
        }

        return Observable.create() { [weak self] emitter in
            let urlRequest = URLRequest(url: endPoint, method: .get)
            let task = self?.urlSession.dataTask(with: urlRequest) { (data, _ , error) in
                guard error == nil else {
                    emitter.onError(error!)
                    return
                }

                if let data = data {
                    emitter.onNext(data)
                }
                emitter.onCompleted()
            }
            task?.resume()

            return Disposables.create() {
                task?.cancel()
            }
        }
    }
}
