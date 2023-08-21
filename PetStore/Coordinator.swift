//
//  Coordinator.swift
//  PetStore
//
//  Created by Brsrld on 20.08.2023.
//

import Foundation
import UIKit

final class Coordinator: CoordinatorProtocol {
    
    // MARK: Properties
    var parentCoordinator: CoordinatorProtocol?
    var children: [CoordinatorProtocol] = []
    var navigationController: UINavigationController?
    
    // MARK: Functions
    func start() {
        let vc = LoginViewControllerBuilder.build(coordinator: self)
        navigationController?.setViewControllers([vc],
                                                 animated: true)
    }

    func eventOccurred(with viewController: UIViewController) {
        navigationController?.pushViewController(viewController,
                                                 animated: true)
    }
}
