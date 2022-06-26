import UIKit
import RxSwift

final class FavoriteViewController: UIViewController {
    
    private enum Section {
        case favorite
    }
    
    private var favoriteCollectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, AblyGoods>?
    private let viewModel = FavoriteViewModel()
    private let disposeBag: DisposeBag = .init()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupFavoriteCollectionView()
        fetchFavoriteGoods()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFavoriteGoods()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = Design.Text.favoritViewTitle
    }
    
    private func fetchFavoriteGoods() {
        viewModel.fetchFavoriteGoods()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] goods in
                self?.populate(goods: goods)
            })
            .disposed(by: disposeBag)
    }
    
    private func populate(goods: [AblyGoods]?) {
        guard let goods = goods else { return }
        var snapshot = NSDiffableDataSourceSnapshot<Section, AblyGoods>()
        snapshot.appendSections([.favorite])
        snapshot.appendItems(goods, toSection: .favorite)
        dataSource?.apply(snapshot)
    }
}

extension FavoriteViewController {
    private func setupFavoriteCollectionView() {
        favoriteCollectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createCollectionViewLayout()
        )
        registerCollectionViewCell()
        setupCollectionViewDataSource()
        setupCollectionViewConstraints()
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
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
    
    private func setupCollectionViewDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, AblyGoods>(collectionView: favoriteCollectionView) { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(GoodsCell.self, for: indexPath) else {
                return UICollectionViewCell()
            }
            cell.setupCell(with: item, isFavoriteView: true)
            return cell
        }
        favoriteCollectionView.dataSource = dataSource
    }
    
    private func setupCollectionViewConstraints() {
        view.addSubview(favoriteCollectionView)
        favoriteCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
