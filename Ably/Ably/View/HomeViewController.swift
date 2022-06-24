//
//  ViewController.swift
//  Ably
//
//  Created by Seul Mac on 2022/06/22.
//

import UIKit

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
    
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Design.Text.homeViewTitle
    }
    
}

extension HomeViewController {
    func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
                                                            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case Section.banners.index:
                return self.creatGoodsSectionLayout()
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
                                              heightDimension: .estimated(400))
        let item = NSCollectionLayoutItem(layoutSize: itemsize)
        let groupSize = NSCollectionLayoutSize(widthDimension: itemsize.widthDimension, heightDimension: itemsize.heightDimension)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        
        return section
    }
    
    private func creatGoodsSectionLayout() -> NSCollectionLayoutSection {
        let itemsize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .estimated(250))
        let item = NSCollectionLayoutItem(layoutSize: itemsize)
        let groupSize = NSCollectionLayoutSize(widthDimension: itemsize.widthDimension,
                                               heightDimension: itemsize.heightDimension)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }

}

