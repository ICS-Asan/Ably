import UIKit
import SnapKit
import SDWebImage

final class GoodsCell: UICollectionViewCell {
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
        button.setImage(Design.Image.normalFavorite, for: .normal)
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
        label.text = Design.Text.newBadgeTitle
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
    
    func setupCell(with goods: AblyGoods, isFavoriteView: Bool) {
        hideFavoriteButton(state: isFavoriteView)
        configureGoodsImageView(with: goods.image)
        configureSellCountLable(with: goods.sellCount)
        configureDiscountPriceRateLable(with: goods.discountPriceRate)
        configureFavoriteButtonImage(favoriteState: goods.isFavorite)
        newBadgeLabel.isHidden = !goods.isNew
        priceLabel.text = goods.price.addComma()
        goodsNameLabel.text = goods.name
        favoriteButton.addTarget(self, action: #selector(didTabFavoriteButton), for: .touchDown)
    }
    
    private func commonInit() {
        setupContainerViewLayout()
        setupGoodsImageViewLayout()
        setupPriceStackView()
        setupGoodsInformationStackView()
        drawUnderLine()
    }
    
    private func hideFavoriteButton(state: Bool) {
        favoriteButton.isHidden = state
    }
    
    private func configureGoodsImageView(with url: String) {
        goodsImageView.sd_setImage(with: URL(string: url))
    }
    
    private func configureSellCountLable(with sellCount: Int) {
        if sellCount >= 10 {
            sellCountLabel.isHidden = false
            sellCountLabel.text = sellCount.addComma() + Design.Text.sellCountLabelSuffix
        } else {
            sellCountLabel.isHidden = true
        }
    }
    
    private func configureDiscountPriceRateLable(with discountRate: Int) {
        if discountRate > 0 {
            discountPriceRateLabel.isHidden = false
            discountPriceRateLabel.text = String(discountRate) + Design.Text.discountRateSign
        } else {
            discountPriceRateLabel.isHidden = true
            discountPriceRateLabel.text = String()
        }
    }
    
    private func configureFavoriteButtonImage(favoriteState: Bool) {
        if favoriteState {
            favoriteButton.setImage(Design.Image.selectedFavorite, for: .normal)
            favoriteButton.tintColor = Design.Color.main
        } else {
            favoriteButton.setImage(Design.Image.normalFavorite, for: .normal)
            favoriteButton.tintColor = .white
        }
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
    
    private func drawUnderLine() {
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
    
    @objc private func didTabFavoriteButton() {
        changeFavoriteState?()
        configureFavoriteButtonImage(favoriteState: !isFavorite)
    }
}
