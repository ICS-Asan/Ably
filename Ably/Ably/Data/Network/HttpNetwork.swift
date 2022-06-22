import Foundation
import RxSwift

class HttpNetwork {
    static let shared = HttpNetwork()
    let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    private func fetch(with endPoint: URL) -> Observable<Data> {
        return Observable.create() { emitter in
            let task = URLSession.shared.dataTask(with: endPoint) { (data, _ , error) in
                guard error == nil else {
                    emitter.onError(error!)
                    return
                }

                if let data = data {
                    emitter.onNext(data)
                }
                emitter.onCompleted()
            }
            task.resume()

            return Disposables.create() {
                task.cancel()
            }
        }
    }
}
