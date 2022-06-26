import UIKit
import RxSwift

class FavoriteViewController: UIViewController {
    
    enum Section {
        case favorite
    }
    
    private var favoriteCollectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, AblyGoods>?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension FavoriteViewController {
    private func setupFavoriteCollectionView() {
        favoriteCollectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createCollectionViewLayout()
        )
        registerCollectionViewCell()
    }
    
    func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
                                                            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            return self.creatFavoriteSectionLayout()
        }
        return layout
    }
    
    private func creatFavoriteSectionLayout() -> NSCollectionLayoutSection {
        let itemsize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .estimated(150))
        let item = NSCollectionLayoutItem(layoutSize: itemsize)
        let groupSize = NSCollectionLayoutSize(widthDimension: itemsize.widthDimension,
                                               heightDimension: itemsize.heightDimension)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    private func registerCollectionViewCell() {
        favoriteCollectionView.register(GoodsCell.self)
    }
}
