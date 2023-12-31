//
//  TabBarController.swift
//  PetStore
//
//  Created by Brsrld on 20.08.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Properties
    private var coordinator: Coordinator
    private var userName: String
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setupTabs()
    }
    
    init(coordinator: Coordinator, userName: String) {
        self.coordinator = coordinator
        self.userName = userName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTabs() {
        let home = self.createNav(title: "Home",
                                  image: UIImage(systemName: "house"),
                                  vc: HomeViewControllerBuilder.build(coordinator: coordinator))
        
        let cart = self.createNav(title: "Cart",
                                  image: UIImage(systemName: "cart"),
                                  vc: CartViewControllerBuilder.build(coordinator: coordinator))
        
        let profile = self.createNav(title: "Profile",
                                     image: UIImage(systemName: "person.crop.circle"),
                                     vc: ProfileViewControllerBuilder.build(coordinator: coordinator, userName: userName))
        
        self.setViewControllers([home, cart, profile], animated: true)
        
    }
    
    private func setDelegates() {
        self.selectedIndex = 0
    }
    
    private func setUI() {
        UITabBar.appearance().backgroundColor = .systemBackground;
    }
    
    private func createNav(title: String, image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        nav.viewControllers.first?.navigationItem.title = title
        
        return nav
    }
}
