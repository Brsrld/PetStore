//
//  SignUpViewModel.swift
//  PetStore
//
//  Created by Brsrld on 21.08.2023.
//

import Foundation

protocol SignUpViewModelProtocol {
    var statePublisher: Published<SignUpViewStates>.Publisher { get }
    var userModel: UserModel? { get set }
    func serviceInit()
    func errorState()
}

final class SignUpViewModel: BaseViewModel<SignUpViewStates> {
    var userModel: UserModel?
    private var service: SignUpServiceable
    
    init(service: SignUpServiceable) {
        self.service = service
    }
    
    func errorState() {
        self.changeState(.error(error: "User info cannot be empty"))
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
