//
//  ProfileViewControllerBuilder.swift
//  PetStore
//
//  Created by Brsrld on 20.08.2023.
//

import Foundation
import UIKit

enum ProfileViewControllerBuilder {
    static func build(coordinator: Coordinator) -> UIViewController {
        let viewController = ProfileViewController()
        viewController.coordinator = coordinator
        
        return viewController
    }
}
