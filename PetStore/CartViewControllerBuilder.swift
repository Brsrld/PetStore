//
//  CartViewControllerBuilder.swift
//  PetStore
//
//  Created by Brsrld on 20.08.2023.
//

import Foundation
import UIKit

enum CartViewControllerBuilder {
    static func build(coordinator: Coordinator) -> UIViewController {
        let service: CartServiceable = CartService()
        let viewModel: CartViewModelProtocol = CartViewModel(service: service)
        
        let viewController = CartViewController(coordinator: coordinator,
                                                viewModel: viewModel)
        
        return viewController
    }
}
