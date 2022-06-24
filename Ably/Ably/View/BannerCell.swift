import UIKit
import SnapKit

class BannerCell: UICollectionViewCell {
    
    private let bannerImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupBannerImageLayout()
    }
    
    private func setupBannerImageLayout() {
        contentView.addSubview(bannerImage)
        bannerImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.height.equalToSuperview()
        }
    }
    
    func setupCell(with image: UIImage) {
        bannerImage.image = image
    }

}
