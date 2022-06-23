import UIKit

final class AblyTabBarController: UITabBarController {
    let homeNavigationController = UINavigationController(rootViewController: ViewController())
    let favoritNavigationController = UIViewController()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupViewController()
        setupTabBarItem()
    }
    
    private func setupViewController() {
        setViewControllers([homeNavigationController, favoritNavigationController], animated: true)
    }
    
    private func setupTabBarItem() {
        homeNavigationController.tabBarItem = UITabBarItem(title: "홈",
                                                           image: UIImage(systemName: "house"),
                                                           selectedImage: UIImage(systemName: "house.fill"))
        favoritNavigationController.tabBarItem = UITabBarItem(title: "좋아요",
                                                           image: UIImage(systemName: "heart"),
                                                           selectedImage: UIImage(systemName: "heart.fill"))
        tabBar.tintColor = UIColor(red: 236/255, green: 94/255, blue: 101/255, alpha: 1)
        tabBar.unselectedItemTintColor = .systemGray
    }
    
    
}
