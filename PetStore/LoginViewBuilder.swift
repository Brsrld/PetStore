//
//  LoginViewBuilder.swift
//  PetStore
//
//  Created by Brsrld on 21.08.2023.
//

import Foundation
import UIKit

enum LoginViewControllerBuilder {
    static func build(coordinator: Coordinator) -> UIViewController {
        let service: SignInServiceable = SignInService()
        let viewModel: LoginViewModelProtocol = LoginViewModel(service: service)
        let viewController = LoginViewController(coordinator: coordinator, viewModel: viewModel)
       
        return viewController
    }
}
