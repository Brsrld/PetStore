//
//  HomeViewController.swift
//  PetStore
//
//  Created by Brsrld on 20.08.2023.
//

import UIKit
import Combine

final class HomeViewController: UIViewController {
    private var coordinator: Coordinator
    private let viewModel: HomeViewModelProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    init(coordinator: Coordinator, viewModel: HomeViewModelProtocol) {
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
                    self?.view.backgroundColor = .systemPink
                case .finished:
                    self?.view.backgroundColor = .orange
                case .ready:
                    self?.view.backgroundColor = .white
                    self?.viewModel.serviceInitialize()
                }
        }.store(in: &cancellables)
    }
}
