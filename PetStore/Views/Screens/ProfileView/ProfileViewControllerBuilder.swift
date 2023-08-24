//
//  ProfileViewControllerBuilder.swift
//  PetStore
//
//  Created by Brsrld on 20.08.2023.
//

import Foundation
import UIKit

// MARK: - Builder
enum ProfileViewControllerBuilder {
    static func build(coordinator: Coordinator, userName: String) -> UIViewController {
        let service: ProfileServiceable = ProfileService()
        let viewModel: ProfileViewModelProtocol = ProfileViewModel(service: service,
                                                                   userName: userName)
        
        let viewController = ProfileViewController(coordinator: coordinator,
                                                   viewModel: viewModel)
        
        return viewController
    }
}
