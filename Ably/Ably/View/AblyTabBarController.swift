import UIKit

final class AblyTabBarController: UITabBarController {
    let homeNavigationController = UINavigationController(rootViewController: HomeViewController())
    let favoritNavigationController = UINavigationController(rootViewController: FavoriteViewController())
    
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
        homeNavigationController.tabBarItem = UITabBarItem(title: Design.Text.homeViewTitle,
                                                           image: Design.Image.normalHomeTabBar,
                                                           selectedImage: Design.Image.selectedHomeTabBar)
        favoritNavigationController.tabBarItem = UITabBarItem(title: Design.Text.favoritViewTitle,
                                                              image: Design.Image.normalFavoritTabBar,
                                                              selectedImage: Design.Image.selectedFavoritTabBar)
        tabBar.tintColor = Design.Color.main
        tabBar.unselectedItemTintColor = .systemGray
    }
    
    
}
