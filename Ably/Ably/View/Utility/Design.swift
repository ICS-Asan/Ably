import UIKit

enum Design {
    
    enum Text {
        static let homeViewTitle = "홈"
        static let favoritViewTitle = "좋아요"
    }
    
    enum Color {
        static let main = UIColor(red: 236/255, green: 94/255, blue: 101/255, alpha: 1)
        static let primaryText = UIColor.label
        static let secondaryText = UIColor(red: 119/255, green: 119/255, blue: 119/255, alpha: 1)
    }
    
    enum Image {
        static let normalHomeTabBar = UIImage(systemName: "house")
        static let selectedHomeTabBar = UIImage(systemName: "house.fill")
        static let normalFavoritTabBar = UIImage(systemName: "heart")
        static let selectedFavoritTabBar = UIImage(systemName: "heart.fill")
    }

}
