//
//  SignUpViewController.swift
//  PetStore
//
//  Created by Brsrld on 21.08.2023.
//

import UIKit
import Combine

class SignUpViewController: UIViewController {
    
    private var coordinator: Coordinator
    private var viewModel: SignUpViewModelProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Base Functions
    init(coordinator: Coordinator,
         viewModel: SignUpViewModelProtocol) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        states()
    }
    
    // MARK: - Custom Functions
    private func states() {
        viewModel.statePublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] (state) in
                switch state {
                case .empty:
                    print("Empty")
                case .error(error: let error):
                    print(error)
                case .loading:
                    self?.view.activityStartAnimating()
                case .finished:
                    self?.view.activityStopAnimating()
                case .ready:
                    self?.view.backgroundColor = .systemBackground
                    self?.title = "SignUp"
                    self?.viewModel.userModel = UserModel(id: nil,
                                                          username: nil,
                                                          firstName: "CEllo",
                                                          lastName: "Tokko",
                                                          email: "celloTokko@gmail.com",
                                                          password: "cello.02",
                                                          phone: "05531786559",
                                                          userStatus: nil)
                    self?.viewModel.serviceInit()
                case .success:
                    guard let coordinator = self?.coordinator else { return }
                    //coordinator.navigationController?.popViewController(animated: true)
                }
            }.store(in: &cancellables)
    }
}
