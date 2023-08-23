//
//  PetsCollectionViewCell.swift
//  PetStore
//
//  Created by Brsrld on 20.08.2023.
//

import UIKit
import SnapKit
import Kingfisher

final class PetsCollectionViewCell: UICollectionViewCell {
    private weak var delegate: PetsCollectionViewCellOutputProtocol?
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
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    private var addToCartButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightText
        button.setTitle("Add to Cart" , for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        contentView.addSubview(petImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(addToCartButton)
        contentView.addSubview(statusLabel)
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = .systemFill
        
        petImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.height.equalTo(64)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(petImage.snp.bottom).offset(18)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
        
        addToCartButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(18)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
    }
    
     @objc
    private func buttonAction() {
        delegate?.onTappedButton(indexPath: indexPath)
    }
    
    func setUpContent(item:PetsCollectionViewCellItems) {
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
        
        switch item.status {
        case .available:
            addToCartButton.isHidden = false
            statusLabel.isHidden = true
            contentView.backgroundColor = .systemFill
        case .pending:
            addToCartButton.isHidden = true
            statusLabel.isHidden = false
            statusLabel.text = "Cannot be bought"
            contentView.backgroundColor = .red.withAlphaComponent(0.2)
        case .sold:
            addToCartButton.isHidden = true
            statusLabel.isHidden = false
            statusLabel.text = "Cannot be bought"
            contentView.backgroundColor = .red.withAlphaComponent(0.2)
        case .none:
            print("none")
        case .placed:
            addToCartButton.isHidden = true
            statusLabel.isHidden = false
            statusLabel.text = "Cannot be bought"
            contentView.backgroundColor = .red.withAlphaComponent(0.2)
        }
    }
}
