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
    
    private lazy var petImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private var addToCartButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 100,
                              y: 100,
                              width: 200,
                              height: 60)
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
        contentView.backgroundColor = .lightText
        contentView.layer.cornerRadius = 8
        
        petImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(12)
            make.height.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(petImage.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(12)
        }
        
        addToCartButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(12)
        }
    }
    
     @objc
    private func buttonAction() {
        delegate?.onTappedButton()
    }
    
    func setUpContent(item:PetsCollectionViewCellItems) {
        self.delegate = item.delegate
        petImage.kf.setImage(with: URL(string: item.image))
        titleLabel.text = item.title
        addToCartButton.titleLabel?.text = "Add to Cart" 
        addToCartButton.addTarget(self,
                                  action: #selector(buttonAction),
                                  for: .touchUpInside)
    }
}
