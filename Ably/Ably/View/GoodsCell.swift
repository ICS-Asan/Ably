import UIKit
import SnapKit
import SDWebImage

class GoodsCell: UICollectionViewCell {
    var changeFavoriteState: (() -> Void)?
    private var isFavorite: Bool {
        return favoriteButton.tintColor == Design.Color.main
    }
    
    private let containerView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private let goodsImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .white
        button.layer.shadowColor = UIColor.systemGray.cgColor
        button.layer.shadowOpacity = 0.8
        
        return button
    }()
    
    private let discountPriceRateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body).bold
        label.textColor = Design.Color.main
        label.textAlignment = .left
        
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body).bold
        label.textColor = Design.Color.primaryText
        label.textAlignment = .left
        
        return label
    }()
    
    private let priceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 5
        
        return stackView
    }()
    
    private let goodsNameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textColor = Design.Color.secondaryText
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        
        return label
    }()
    
    private let sellCountLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textColor = Design.Color.secondaryText
        label.numberOfLines = 1
        
        return label
    }()
    
    private let newBadgeLabel: UILabel = {
        let label = UILabel()
        label.text = "NEW"
        label.font = .preferredFont(forTextStyle: .caption2).bold
        label.textColor = Design.Color.secondaryText
        label.textAlignment = .center
        label.layer.cornerRadius = 3
        label.layer.borderWidth = 1
        label.layer.borderColor = Design.Color.secondaryText.cgColor
        
        return label
    }()
    
    private let sellInformationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return stackView
    }()
    
    private let goodsInformationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 20
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func setupCell(with goods: AblyGoods) {
        configureGoodsImageView(with: goods.image)
        configureSellCountLable(with: goods.sellCount)
        configureDiscountPriceRateLable(with: goods.discountPriceRate)
        configureFavoriteButton(favoriteState: goods.isFavorite)
        newBadgeLabel.isHidden = !goods.isNew
        priceLabel.text = String(goods.price)
        goodsNameLabel.text = goods.name
        favoriteButton.addTarget(self, action: #selector(didTabFavoriteButton), for: .touchDown)
    }
    
    func configureGoodsImageView(with url: String) {
        goodsImageView.sd_setImage(with: URL(string: url))
    }
    
    func configureDiscountPriceRateLable(with discountRate: Int) {
        if discountRate > 0 {
            discountPriceRateLabel.isHidden = false
            discountPriceRateLabel.text = String(discountRate) + "%"
        } else {
            discountPriceRateLabel.isHidden = true
            discountPriceRateLabel.text = String()
        }
    }
    
    func configureSellCountLable(with sellCount: Int) {
        if sellCount >= 10 {
            sellCountLabel.isHidden = false
            sellCountLabel.text = String(sellCount) + "개 구매중"
        } else {
            sellCountLabel.isHidden = true
        }
    }
    
    private func configureFavoriteButton(favoriteState: Bool) {
        if favoriteState {
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            favoriteButton.tintColor = Design.Color.main
        } else {
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            favoriteButton.tintColor = .white
        }
    }
    
    private func commonInit() {
        setupContainerViewLayout()
        setupGoodsImageViewLayout()
        setupPriceStackView()
        setupGoodsInformationStackView()
        drawUnderLine()
    }
    
    private func setupContainerViewLayout() {
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.height.equalToSuperview()
        }
    }
    
    private func setupGoodsImageViewLayout() {
        containerView.addSubview(goodsImageView)
        containerView.addSubview(favoriteButton)
        goodsImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(20)
            make.width.height.equalTo(100)
        }
        favoriteButton.snp.makeConstraints { make in
            make.top.trailing.equalTo(goodsImageView).inset(5)
        }
    }
    
    private func setupPriceStackView() {
        priceStackView.addArrangedSubview(discountPriceRateLabel)
        priceStackView.addArrangedSubview(priceLabel)
        discountPriceRateLabel.isHidden = true
        setupPriceStackViewLayout()
    }
    
    private func setupPriceStackViewLayout() {
        containerView.addSubview(priceStackView)
        priceStackView.snp.makeConstraints { make in
            make.top.equalTo(goodsImageView.snp.top).inset(5)
            make.leading.equalTo(goodsImageView.snp.trailing).inset(-10)
            make.height.equalTo(priceLabel.snp.height)
        }
    }
    
    private func setupGoodsInformationStackView() {
        setupSellInformationStackView()
        goodsInformationStackView.addArrangedSubview(goodsNameLabel)
        goodsInformationStackView.addArrangedSubview(sellInformationStackView)
        newBadgeLabel.snp.makeConstraints { make in
            make.width.equalTo(35)
            make.height.equalTo(17)
        }
        setupGoodsInformationStackViewLayout()
    }
    
    private func setupSellInformationStackView() {
        sellInformationStackView.addArrangedSubview(newBadgeLabel)
        sellInformationStackView.addArrangedSubview(sellCountLabel)
        newBadgeLabel.isHidden = true
    }
    
    private func setupGoodsInformationStackViewLayout() {
        containerView.addSubview(goodsInformationStackView)
        goodsInformationStackView.snp.makeConstraints { make in
            make.top.equalTo(priceStackView.snp.bottom).inset(-10)
            make.leading.equalTo(priceStackView)
            make.trailing.equalToSuperview().inset(20)
        }
    }
    
    @objc private func didTabFavoriteButton() {
        changeFavoriteState?()
        toggleFavoriteButtonImage()
    }
    
    func toggleFavoriteButtonImage() {
        if isFavorite {
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            favoriteButton.tintColor = .white
        } else {
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            favoriteButton.tintColor = Design.Color.main
        }
    }
    
    func drawUnderLine() {
        let underLine = CALayer()
        underLine.frame = CGRect(
            x: 0,
            y: contentView.frame.height,
            width: contentView.frame.width,
            height: 1
        )
        underLine.backgroundColor = UIColor.secondarySystemBackground.cgColor
        layer.addSublayer(underLine)
    }
}

extension UIFont {
    func withTraits(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        if let descriptor = fontDescriptor.withSymbolicTraits(traits) {
            return UIFont(descriptor: descriptor, size: 0)
        }
        
        return self
    }
    
    var bold: UIFont {
        return withTraits(traits: .traitBold)
    }
}
