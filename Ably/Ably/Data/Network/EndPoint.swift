import Foundation

enum EndPoint {
    case home
    case paging(lastId: Int)

    var url: URL? {
        switch self {
        case .home:
            return URL(string: Path.home.string)
        case .paging(let lastId):
            var components = URLComponents(string: Path.paging.string)
            let lastId = URLQueryItem(name: "lastId", value: "\(lastId)")
            components?.queryItems = [lastId]
            return components?.url
        }
    }
}

private enum Path: String {
    private static let mainPath = "http://d2bab9i9pr8lds.cloudfront.net/api/home"
    
    case home
    case paging
    
    var string: String {
        switch self {
        case .home:
            return Path.mainPath
        case .paging:
            return Path.mainPath + "/goods"
        }
    }
}
