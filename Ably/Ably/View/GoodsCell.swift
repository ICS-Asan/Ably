import UIKit
import SDWebImage

class GoodsCell: UICollectionViewCell {
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let goodsImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.layer.cornerRadius = 10
        
        return imageView
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
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
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
    
    private let newBadgeLable: UILabel = {
       let label = UILabel()
        label.text = "NEW"
        label.font = .preferredFont(forTextStyle: .caption1).bold
        label.textColor = Design.Color.secondaryText
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 1
        label.layer.borderColor = Design.Color.secondaryText.cgColor
        
        return label
    }()
    
    private let sellInformationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 5
        
       return stackView
    }()
    
    private let goodsInformationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
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
        newBadgeLable.isHidden = !goods.isNew
        priceLabel.text = String(goods.price)
        goodsNameLabel.text = goods.name
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
    
    private func commonInit() {
        setupContainerViewLayout()
        setupGoodsImageViewLayout()
        setupPriceStackView()
        setupGoodsInformationStackView()
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
        goodsImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(20)
            make.width.height.equalTo(100)
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
            make.top.equalTo(goodsImageView).offset(5)
            make.leading.equalTo(goodsImageView).offset(10)
        }
    }
    
    private func setupGoodsInformationStackView() {
        setupSellInformationStackView()
        goodsInformationStackView.addArrangedSubview(goodsNameLabel)
        goodsInformationStackView.addArrangedSubview(sellInformationStackView)
        setupGoodsInformationStackViewLayout()
    }
    
    private func setupSellInformationStackView() {
        sellInformationStackView.addArrangedSubview(newBadgeLable)
        sellInformationStackView.addArrangedSubview(sellCountLabel)
        newBadgeLable.isHidden = true
    }
    
    private func setupGoodsInformationStackViewLayout() {
        containerView.addSubview(goodsInformationStackView)
        goodsInformationStackView.snp.makeConstraints { make in
            make.top.equalTo(priceStackView).offset(10)
            make.leading.equalTo(priceStackView)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(30)
        }
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
