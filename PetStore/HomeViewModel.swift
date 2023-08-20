//
//  HomeViewModel.swift
//  PetStore
//
//  Created by Brsrld on 20.08.2023.
//

import Foundation

protocol HomeViewModelProtocol {
    var statePublisher: Published<HomeViewStates>.Publisher { get }
    func serviceInitialize()
}

final class HomeViewModel: BaseViewModel<HomeViewStates> {
    let service: HomeViewServiceable
    
    init(service: HomeViewServiceable) {
        self.service = service
    }
    
    func serviceInitialize() {
        changeState(.loading)
        Task { [weak self] in
            guard let self = self else { return }
            let result = await self.service.fetchPets(petStatus: .available)
            self.changeState(.finished)
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                self.changeState(.error(error: failure.localizedDescription))
            }
        }
    }
}

// MARK: - HomeViewModelProtocol
extension HomeViewModel: HomeViewModelProtocol {
    var statePublisher: Published<HomeViewStates>.Publisher {
        $states
    }
}
