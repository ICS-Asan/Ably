import Foundation
import RxSwift

class AblyNetworkRepository: NetworkRepository {
    
    func fetchAblyHomeData() -> Observable<AblyHomeData> {
        let ablyHomeData = HTTPNetwork.shared.fetch(with: EndPoint.home.url)
            .map { data -> AblyHomeData in
                let decodedData = JSONParser.decodeData(of: data, type: AblyHomeDTO.self)
                
                return decodedData?.toDomain() ?? AblyHomeData(banners: [], goods: [])
            }
        
        return ablyHomeData
    }

    func fetchAblyGoodsForPaging(with lastId: Int) -> Observable<AblyHomeData> {
        let ablyHomeData = HTTPNetwork.shared.fetch(with: EndPoint.paging(lastId: lastId).url)
            .map { data -> AblyHomeData in
                let decodedData = JSONParser.decodeData(of: data, type: AblyHomeDTO.self)
                
                return decodedData?.toDomain() ?? AblyHomeData(banners: [], goods: [])
            }
        
        return ablyHomeData
    }
}
