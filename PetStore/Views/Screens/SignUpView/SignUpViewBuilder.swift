//
//  SignUpViewBuilder.swift
//  PetStore
//
//  Created by Brsrld on 21.08.2023.
//

import Foundation
import UIKit

// MARK: - SignUpViewBuilder
enum SignUpViewBuilder {
    static func build(coordinator: Coordinator) -> UIViewController {
        let service: SignUpServiceable = SignUpService()
        let viewModel: SignUpViewModelProtocol = SignUpViewModel(service: service)
        let viewController = SignUpViewController(coordinator: coordinator, viewModel: viewModel)
       
        return viewController
    }
}
