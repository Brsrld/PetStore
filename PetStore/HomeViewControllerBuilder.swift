//
//  HomeViewControllerBuilder.swift
//  PetStore
//
//  Created by Brsrld on 20.08.2023.
//

import Foundation
import UIKit

enum HomeViewControllerBuilder {
    static func build(coordinator: Coordinator) -> UIViewController {
        let service: HomeViewServiceable = HomeViewService()
        let viewModel: HomeViewModelProtocol = HomeViewModel(service: service)
        let viewController = HomeViewController(coordinator: coordinator, viewModel: viewModel)
       
        return viewController
    }
}
