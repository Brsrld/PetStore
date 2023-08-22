//
//  LoginViewModel.swift
//  PetStore
//
//  Created by Brsrld on 22.08.2023.
//

import Foundation

protocol LoginViewModelProtocol {
    var statePublisher: Published<LoginViewStates>.Publisher { get }
    func serviceInit(userName: String, password: String)
    func errorState()
}

final class LoginViewModel: BaseViewModel<LoginViewStates> {
    private var service: SignInServiceable
    
    init(service: SignInServiceable) {
        self.service = service
    }
    
    func errorState() {
        self.changeState(.error(error: "User info cannot be empty"))
    }
    
    func serviceInit(userName: String, password: String) {
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

extension LoginViewModel: LoginViewModelProtocol {
    var statePublisher: Published<LoginViewStates>.Publisher {
        $states
    }
}