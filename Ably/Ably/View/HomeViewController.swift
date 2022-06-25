//
//  ViewController.swift
//  Ably
//
//  Created by Seul Mac on 2022/06/22.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController {
    
    enum Section {
        case banners
        case goods
        
        var index: Int {
            switch self {
            case .banners:
                return 0
            case .goods:
                return 1
            }
        }
    }
    
    private enum AblyHomeItem: Hashable {
        case banner(AblyBanner)
        case goods(AblyGoods)
    }
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, AblyHomeItem>?
    private let viewModel = HomeViewModel()
    private let loadFinishedObserver: PublishSubject<AblyHomeData> = .init()
    private let disposeBag: DisposeBag = .init()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        bind()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        bind()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Design.Text.homeViewTitle
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
        registerCollectionViewCell()
        setupCollectionViewDataSource()
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        collectionView.dataSource = dataSource
        viewModel.fetchAblyHomeData()
            .subscribe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] data in
                self?.populate(banners: data.banners ?? [], goods: data.goods)
                self?.loadFinishedObserver.onNext(data)
            })
            .disposed(by: disposeBag)
        }
    
    private func bind() {
        let input = HomeViewModel.Input(loadFinishedObserver: loadFinishedObserver)
        let _ = viewModel.transform(input)
    }
    
}

extension HomeViewController {
    func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
                                                            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case Section.banners.index:
                return self.creatBannerSectionLayout()
            case Section.goods.index:
                return self.creatGoodsSectionLayout()
            default:
                return nil
            }
        }
        return layout
    }
    
    private func creatBannerSectionLayout() -> NSCollectionLayoutSection {
        let itemsize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalWidth(0.73))
        let item = NSCollectionLayoutItem(layoutSize: itemsize)
        let groupSize = NSCollectionLayoutSize(widthDimension: itemsize.widthDimension, heightDimension: itemsize.heightDimension)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        
        return section
    }
    
    private func creatGoodsSectionLayout() -> NSCollectionLayoutSection {
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
        collectionView.register(BannerCell.self)
        collectionView.register(GoodsCell.self)
    }
    
    private func setupCollectionViewDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, AblyHomeItem>(collectionView: collectionView) { collectionView, indexPath, item in
            switch item {
            case .banner(let banner):
                guard let cell = collectionView.dequeueReusableCell(BannerCell.self, for: indexPath) else {
                    return UICollectionViewCell()
                }
                cell.setupCell(with: banner.image)
                return cell
            case .goods(let goods):
                guard let cell = collectionView.dequeueReusableCell(GoodsCell.self, for: indexPath) else {
                    return UICollectionViewCell()
                }
                cell.setupCell(with: goods)
                return cell
            }
        }
    }
    
    private func populate(banners: [AblyBanner], goods: [AblyGoods]) {
        let bannerItems = banners.map { AblyHomeItem.banner($0) }
        let goodsItems = goods.map { AblyHomeItem.goods($0) }
        var snapshot = NSDiffableDataSourceSnapshot<Section, AblyHomeItem>()
        snapshot.appendSections([.banners, .goods])
        snapshot.appendItems(bannerItems, toSection: .banners)
        snapshot.appendItems(goodsItems, toSection: .goods)
        dataSource?.apply(snapshot)
    }

}
