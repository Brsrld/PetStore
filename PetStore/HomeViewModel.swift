//
//  HomeViewModel.swift
//  PetStore
//
//  Created by Brsrld on 20.08.2023.
//

import Foundation

protocol HomeViewModelProtocol {
    var statePublisher: Published<HomeViewStates>.Publisher { get }
    var petsData: [PetModel] { get set }
    var petStatus: PetStatus { get set }
    func serviceInitialize()
    func saveCartsData(index: Int?)
}

final class HomeViewModel: BaseViewModel<HomeViewStates> {
    var petsData: [PetModel] = []
    var petStatus: PetStatus = .available
    private var cartPets: [PetModel] = []
    private let service: HomeViewServiceable
    
    init(service: HomeViewServiceable) {
        self.service = service
    }
    
    func saveCartsData(index: Int?) {
        guard let index = index else { return }
        let condition = cartPets.contains(where: { pet in
            if pet.id == petsData[index].id {
               return true
            } else {
                return false
            }
        })
        
        if condition {
            petsData[index].quantitiy! += 1
        } else {
            petsData[index].quantitiy = 0
            cartPets.append(petsData[index])
        }
        
        UserDefaults.standard.set(cartPets.encode(), forKey: "cartsData")
    }
    
    func serviceInitialize() {
        changeState(.loading)
        Task { [weak self] in
            guard let self = self else { return }
            let result = await self.service.fetchPets(petStatus: petStatus)
            self.changeState(.finished)
            switch result {
            case .success(let success):
                self.petsData = success
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
