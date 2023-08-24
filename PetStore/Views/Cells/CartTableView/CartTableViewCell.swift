//
//  CartTableViewCell.swift
//  PetStore
//
//  Created by Brsrld on 22.08.2023.
//

import UIKit
import SnapKit
import Kingfisher

final class CartTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    private weak var delegate: CartTableViewCellOutputProtocol?
    private var indexPath: Int?
    
    private lazy var petImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 8
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 2
        label.textAlignment = .left
        return label
    }()
    
    private var addToCartButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightText
        button.setTitle("Place Order" , for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.backgroundColor = .orange
        return button
    }()
    
    // MARK: - Functions
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    private func setUpView() {
        contentView.addSubview(petImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(addToCartButton)
        
        petImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalTo(64)
            make.width.equalTo(64)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalTo(petImage.snp.trailing).offset(4)
        }
        
        addToCartButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().offset(-12)
            make.leading.equalTo(titleLabel.snp.trailing).offset(12)
            make.trailing.equalToSuperview()
            make.width.equalTo(96)
        }
    }
    
    @objc
    private func buttonAction() {
        delegate?.onTappedButton(indexPath: indexPath)
    }
    
    func setUpContent(item: CarTableViewCellItem) {
        self.indexPath = item.indexPath
        self.delegate = item.delegate
        if let image = item.image, let title = item.title {
            petImage.kf.setImage(with: URL(string: image),
                                 placeholder: UIImage(systemName: "photo"))
            titleLabel.text = title.capitalized
        }
        
        addToCartButton.addTarget(self,
                                  action: #selector(buttonAction),
                                  for: .touchUpInside)
    }
}
