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
        let viewController = CartViewController()
        viewController.coordinator = coordinator
        
        return viewController
    }
}
