//
//  EmptyView.swift
//  PetStore
//
//  Created by Brsrld on 23.08.2023.
//

import UIKit
import SnapKit

final class EmptyView: UIView {
    // MARK: - Peoperties
    private var item: EmptyViewItems
    
    private lazy var image: UIImageView = {
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
        label.textAlignment = .center
        label.backgroundColor = .clear
        return label
    }()
    
    private var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        return button
    }()
    
    // MARK: - Functions
    init(item: EmptyViewItems) {
        self.item = item
        super.init(frame: CGRectZero)
        self.setUpView()
        self.setUpContent()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc
    private func buttonAction() {
        item.delegate?.onTappedButton()
    }
    
    private func setUpView() {
        self.addSubview(image)
        self.addSubview(titleLabel)
        self.addSubview(button)
        self.layer.cornerRadius = 8
        
        image.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(12)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.height.equalTo(48)
            make.width.equalTo(48)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.height.equalTo(48)
        }
        
        button.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.height.equalTo(32)
        }
        
        button.addTarget(self,
                         action: #selector(buttonAction),
                         for: .touchUpInside)
        
        switch item.buttonType {
        case .noButton:
            button.isHidden = true
        case .withButton:
            button.backgroundColor = .red
            button.setTitleColor(.white, for: .normal)
        case .none:
            fatalError("Something get wrong")
        }
    
    }
    
    private func setUpContent() {
        if let image = item.image, let title = item.title {
            self.image.image = UIImage(systemName: image)
            titleLabel.text = title.capitalized
            button.setTitle(item.buttonName , for: .normal)
        }
    }
}
