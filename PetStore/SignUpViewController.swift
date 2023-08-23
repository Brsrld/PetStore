//
//  SignUpViewController.swift
//  PetStore
//
//  Created by Brsrld on 21.08.2023.
//

import UIKit
import Combine
import SnapKit

final class SignUpViewController: UIViewController {
    // MARK: - UI Properties
    
    private lazy var firstNameTextFiled: UITextField = {
        let textFiled = UITextField()
        textFiled.placeholder = "First Name"
        textFiled.font = UIFont.systemFont(ofSize: 15)
        textFiled.borderStyle = UITextField.BorderStyle.roundedRect
        textFiled.autocorrectionType = UITextAutocorrectionType.no
        textFiled.keyboardType = UIKeyboardType.default
        textFiled.returnKeyType = UIReturnKeyType.done
        textFiled.clearButtonMode = UITextField.ViewMode.whileEditing
        textFiled.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return textFiled
    }()
    
    private lazy var lastNameTextfiled: UITextField = {
        let textFiled = UITextField()
        textFiled.placeholder = "Last Name"
        textFiled.font = UIFont.systemFont(ofSize: 15)
        textFiled.borderStyle = UITextField.BorderStyle.roundedRect
        textFiled.autocorrectionType = UITextAutocorrectionType.no
        textFiled.keyboardType = UIKeyboardType.default
        textFiled.returnKeyType = UIReturnKeyType.done
        textFiled.clearButtonMode = UITextField.ViewMode.whileEditing
        textFiled.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return textFiled
    }()
    
    private lazy var emailTextfiled: UITextField = {
        let textFiled = UITextField()
        textFiled.placeholder = "E-mail"
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
        return textFiled
    }()
    
    private lazy var phoneTextfiled: UITextField = {
        let textFiled = UITextField()
        textFiled.placeholder = "Phone"
        textFiled.font = UIFont.systemFont(ofSize: 15)
        textFiled.borderStyle = UITextField.BorderStyle.roundedRect
        textFiled.autocorrectionType = UITextAutocorrectionType.no
        textFiled.keyboardType = UIKeyboardType.default
        textFiled.returnKeyType = UIReturnKeyType.done
        textFiled.clearButtonMode = UITextField.ViewMode.whileEditing
        textFiled.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return textFiled
    }()
    
    private lazy var userNameTextfiled: UITextField = {
        let textFiled = UITextField()
        textFiled.placeholder = "User Name"
        textFiled.font = UIFont.systemFont(ofSize: 15)
        textFiled.borderStyle = UITextField.BorderStyle.roundedRect
        textFiled.autocorrectionType = UITextAutocorrectionType.no
        textFiled.keyboardType = UIKeyboardType.default
        textFiled.returnKeyType = UIReturnKeyType.done
        textFiled.clearButtonMode = UITextField.ViewMode.whileEditing
        textFiled.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return textFiled
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
    private var viewModel: SignUpViewModelProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Base Functions
    init(coordinator: Coordinator,
         viewModel: SignUpViewModelProtocol) {
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
                    self?.alert(message: error)
                case .loading:
                    self?.view.activityStartAnimating()
                case .finished:
                    self?.view.activityStopAnimating()
                case .ready:
                    self?.prepareUI()
                    self?.prepareTextFields()
                    self?.prepareButton()
                case .success:
                    self?.toastMessage("Successfully SignUp")
                    guard let coordinator = self?.coordinator else { return }
                    coordinator.navigationController?.popViewController(animated: true)
                }
            }.store(in: &cancellables)
    }
    
    private func prepareUI() {
        view.backgroundColor = .systemBackground
        title = "SignUp"
    }
    
    private func prepareButton() {
        self.view.addSubview(signUpButton)
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(emailTextfiled.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(36)
        }
        
        signUpButton.addTarget(self,
                                  action: #selector(signUpButtonAction),
                                  for: .touchUpInside)
    }
    
    private func prepareTextFields() {
        self.view.addSubview(firstNameTextFiled)
        self.view.addSubview(passwordTextfiled)
        self.view.addSubview(lastNameTextfiled)
        self.view.addSubview(userNameTextfiled)
        self.view.addSubview(phoneTextfiled)
        self.view.addSubview(emailTextfiled)
        
        firstNameTextFiled.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(36)
        }
        
        lastNameTextfiled.snp.makeConstraints { make in
            make.top.equalTo(firstNameTextFiled.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(36)
        }
        
        userNameTextfiled.snp.makeConstraints { make in
            make.top.equalTo(lastNameTextfiled.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(36)
        }
        
        passwordTextfiled.snp.makeConstraints { make in
            make.top.equalTo(userNameTextfiled.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(36)
        }
        
        phoneTextfiled.snp.makeConstraints { make in
            make.top.equalTo(passwordTextfiled.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(36)
        }
        
        emailTextfiled.snp.makeConstraints { make in
            make.top.equalTo(phoneTextfiled.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(36)
        }
    }
    
    @objc
   private func signUpButtonAction() {
       guard let username = userNameTextfiled.text,
             let firstName = userNameTextfiled.text,
             let lastName = userNameTextfiled.text,
             let email = userNameTextfiled.text,
             let password = userNameTextfiled.text,
             let phone = userNameTextfiled.text else {
           viewModel.errorState()
           return
       }
       
       viewModel.userModel  = UserModel(id: 0,
                                        username: username,
                                        firstName: firstName,
                                        lastName: lastName,
                                        email: email,
                                        password: password,
                                        phone: phone,
                                        userStatus: 1)
       viewModel.serviceInit()
   }
}
