//
//  TabBarControllerBuilder.swift
//  PetStore
//
//  Created by Brsrld on 20.08.2023.
//

import Foundation
import UIKit

enum TabBarControllerBuilder {
    static func build(coordinator: Coordinator) -> UIViewController {
        let viewController = TabBarController(coordinator: coordinator)
        
        return viewController
    }
}
