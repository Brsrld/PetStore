//
//  ProfileViewController.swift
//  PetStore
//
//  Created by Brsrld on 20.08.2023.
//

import UIKit
import Combine
import SnapKit

final class ProfileViewController: UIViewController {
    
    private lazy var firstNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private lazy var lastNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private var logoutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightText
        button.setTitle("Logout" , for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.backgroundColor = .red
        return button
    }()
    
    private var coordinator: Coordinator
    private var viewModel: ProfileViewModelProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        states()
    }
    
    // MARK: - Base Functions
    init(coordinator: Coordinator,
         viewModel: ProfileViewModelProtocol) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Functions
    private func states() {
        viewModel.statePublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] (state) in
                switch state {
                case .error(error: let error):
                    print(error)
                case .loading:
                    self?.view.activityStartAnimating()
                case .finished:
                    self?.view.activityStopAnimating()
                case .ready:
                    self?.view.backgroundColor = .white
                    self?.prepareLabels()
                    self?.prepareButton()
                    self?.viewModel.getUserData()
                case .logoutSuccess:
                    self?.coordinator.navigationController?.popToRootViewController(animated: true)
                }
            }.store(in: &cancellables)
    }
    
    private func prepareLabels() {
        view.addSubview(firstNameLabel)
        view.addSubview(lastNameLabel)
        view.addSubview(emailLabel)
        view.addSubview(phoneLabel)
        
        firstNameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.height.equalTo(32)
        }
        
        lastNameLabel.snp.makeConstraints { make in
            make.top.equalTo(firstNameLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.height.equalTo(32)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(lastNameLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.height.equalTo(32)
        }
        
        phoneLabel.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.height.equalTo(32)
        }
        
        guard let firstname = viewModel.userData?.firstName,
              let lastName = viewModel.userData?.lastName,
              let email = viewModel.userData?.email,
              let phone = viewModel.userData?.phone else { return }
        
        firstNameLabel.text = "Firstname: \(firstname)"
        lastNameLabel.text = "Lastname: \(lastName)"
        emailLabel.text = "E-Mail: \(email)"
        phoneLabel.text = "Phone Number: \(phone)"
    }
    
    private func prepareButton() {
        view.addSubview(logoutButton)
        logoutButton.addTarget(self,
                                  action: #selector(buttonAction),
                                  for: .touchUpInside)
        
        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(phoneLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.height.equalTo(32)
        }
    }
    
    @objc
    private func buttonAction() {
        viewModel.logOut()
    }
}
