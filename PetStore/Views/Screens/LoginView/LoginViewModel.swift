//
//  LoginViewModel.swift
//  PetStore
//
//  Created by Brsrld on 22.08.2023.
//

import Foundation

// MARK: - LoginViewModelProtocol
protocol LoginViewModelProtocol {
    var statePublisher: Published<LoginViewStates>.Publisher { get }
    func serviceInit(userName: String, password: String)
    func errorState()
}

final class LoginViewModel: BaseViewModel<LoginViewStates> {
    // MARK: - Properties
    private var service: SignInServiceable
    
    // MARK: - Functions
    init(service: SignInServiceable) {
        self.service = service
    }
    
    func errorState() {
        self.changeState(.error(error: "User info cannot be empty"))
    }
    
    func serviceInit(userName: String, password: String) {
        if userName == "" && password == "" {
            changeState(.error(error: "Username and password cannot be empty"))
            return
        }
        
        changeState(.loading)
        Task { [weak self] in
            guard let self = self else { return }
            let result = await self.service.signIn(userName: userName, password: password)
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


// MARK: - LoginViewModelProtocol
extension LoginViewModel: LoginViewModelProtocol {
    var statePublisher: Published<LoginViewStates>.Publisher {
        $states
    }
}
