//
//  SignUpViewModel.swift
//  PetStore
//
//  Created by Brsrld on 21.08.2023.
//

import Foundation

// MARK: - SignUpViewModelProtocol
protocol SignUpViewModelProtocol {
    var statePublisher: Published<SignUpViewStates>.Publisher { get }
    var userModel: UserModel? { get set }
    func serviceInit()
    func preparaBody(userName: String?,
                     firstName: String?,
                     lastName: String?,
                     email: String?,
                     password: String?,
                     phone: String?)
}

final class SignUpViewModel: BaseViewModel<SignUpViewStates> {
    // MARK: - Properties
    var userModel: UserModel?
    private var service: SignUpServiceable
    
    init(service: SignUpServiceable) {
        self.service = service
    }
    
    // MARK: - Functions
    func errorState() {
        self.changeState(.error(error: "User info cannot be empty"))
    }
    
    func preparaBody(userName: String?,
                     firstName: String?,
                     lastName: String?,
                     email: String?,
                     password: String?,
                     phone: String?) {
        
        guard let username = userName,
              let firstName = firstName,
              let lastName = lastName,
              let email = email,
              let password = password,
              let phone = phone else {
                  self.changeState(.error(error: "User info cannot be empty"))
            return
        }
        
        userModel  = UserModel(id: 0,
                               username: username,
                               firstName: firstName,
                               lastName: lastName,
                               email: email,
                               password: password,
                               phone: phone,
                               userStatus: 1)
        
    }
    
    func serviceInit() {
        changeState(.loading)
        Task { [weak self] in
            guard let self = self else { return }
            guard let userModel = userModel else { return }
            let result = await self.service.signUp(userModel: userModel)
            self.changeState(.finished)
            switch result {
            case .success(let data):
                print(data)
                self.changeState(.success)
            case .failure(let failure):
                self.changeState(.error(error: failure.localizedDescription))
            }
        }
    }
}

// MARK: - HomeViewModelProtocol
extension SignUpViewModel: SignUpViewModelProtocol {
    var statePublisher: Published<SignUpViewStates>.Publisher {
        $states
    }
}
