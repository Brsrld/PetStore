//
//  LoginViewController.swift
//  PetStore
//
//  Created by Brsrld on 21.08.2023.
//

import UIKit
import SnapKit
import Combine

final class LoginViewController: UIViewController {
    
    private lazy var userNameTextFiled: UITextField = {
        let textFiled = UITextField()
        textFiled.placeholder = "Username"
        textFiled.font = UIFont.systemFont(ofSize: 15)
        textFiled.borderStyle = UITextField.BorderStyle.roundedRect
        textFiled.autocorrectionType = UITextAutocorrectionType.no
        textFiled.keyboardType = UIKeyboardType.default
        textFiled.returnKeyType = UIReturnKeyType.done
        textFiled.clearButtonMode = UITextField.ViewMode.whileEditing
        textFiled.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return textFiled
    }()
    
    private lazy var passwordTextfiled: UITextField = {
        let textFiled = UITextField()
        textFiled.placeholder = "Password"
        textFiled.font = UIFont.systemFont(ofSize: 15)
        textFiled.borderStyle = UITextField.BorderStyle.roundedRect
        textFiled.autocorrectionType = UITextAutocorrectionType.no
        textFiled.keyboardType = UIKeyboardType.default
        textFiled.returnKeyType = UIReturnKeyType.done
        textFiled.clearButtonMode = UITextField.ViewMode.whileEditing
        textFiled.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textFiled.isSecureTextEntry = true
        return textFiled
    }()
    
    private lazy var petImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.layer.cornerRadius = 8
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private var signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemOrange
        button.setTitle("Sign In" , for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        return button
    }()
    
    private var signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemOrange
        button.setTitle("Sign Up" , for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        return button
    }()
    
    private var coordinator: Coordinator
    private var viewModel: LoginViewModelProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Base Functions
    init(coordinator: Coordinator, viewModel: LoginViewModelProtocol) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        states()
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
                    self?.prepareView()
                    self?.prepareImage()
                    self?.prepareTextFields()
                    self?.prepareButtons()
                case .success:
                    self?.toastMessage("Successfully SignIp")
                    guard let coordinator = self?.coordinator else { return }
                    coordinator.eventOccurred(with: TabBarControllerBuilder.build(coordinator: coordinator))
                    coordinator.navigationController?.isNavigationBarHidden = true
                }
            }.store(in: &cancellables)
    }
    
    private func prepareView() {
        view.backgroundColor = .systemBackground
        title = "Login"
    }
    
    private func prepareButtons() {
        view.addSubview(signUpButton)
        view.addSubview(signInButton)
        
        signUpButton.addTarget(self,
                                  action: #selector(signUpButtonAction),
                                  for: .touchUpInside)
        
        signInButton.addTarget(self,
                                  action: #selector(signInButtonAction),
                                  for: .touchUpInside)
        
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextfiled.snp.bottom).offset(18)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(32)
            make.width.equalTo(96)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextfiled.snp.bottom).offset(18)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(32)
            make.width.equalTo(96)
        }
    }
    
    private func prepareImage() {
        self.view.addSubview(petImage)
        petImage.image = UIImage(named: "loginImage")
        petImage.backgroundColor = .red
        petImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalToSuperview().dividedBy(4)
        }
    }
    
    private func prepareTextFields() {
        self.view.addSubview(userNameTextFiled)
        self.view.addSubview(passwordTextfiled)
        
        userNameTextFiled.snp.makeConstraints { make in
            make.top.equalTo(petImage.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(36)
        }
        
        passwordTextfiled.snp.makeConstraints { make in
            make.top.equalTo(userNameTextFiled.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(36)
        }
    }
    
    @objc
   private func signUpButtonAction() {
       coordinator.eventOccurred(with: SignUpViewBuilder.build(coordinator: coordinator))
   }
    
    @objc
   private func signInButtonAction() {
       guard let userName = userNameTextFiled.text,
             let password = passwordTextfiled.text else {
           viewModel.errorState()
           return
       }
       viewModel.serviceInit(userName: userName,
                             password: password)
   }
}
