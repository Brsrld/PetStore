//
//  HomeViewModel.swift
//  PetStore
//
//  Created by Brsrld on 20.08.2023.
//

import Foundation

// MARK: - HomeViewModelProtocol
protocol HomeViewModelProtocol {
    var statePublisher: Published<HomeViewStates>.Publisher { get }
    var petsData: [PetModel] { get set }
    var petStatus: PetStatus { get set }
    func serviceInitialize()
    func saveCartsData(index: Int?)
    func readData()
}

final class HomeViewModel: BaseViewModel<HomeViewStates> {
    // MARK: - Properties
    var petsData: [PetModel] = []
    var petStatus: PetStatus = .available
    private var cartPets: [PetModel] = []
    private let service: HomeViewServiceable
    
    // MARK: - Functions
    init(service: HomeViewServiceable) {
        self.service = service
    }
    
    func saveCartsData(index: Int?) {
        guard let index = index else { return }
        cartPets.append(petsData[index])
        petsData.remove(at: index)
        UserDefaults.standard.set(cartPets.encode(), forKey: "cartsData")
        changeState(.successAddedCart)
    }
    
    func readData() {
        if let data = UserDefaults.standard.object(forKey: "cartsData") as? Data,
           let pets = try? JSONDecoder().decode([PetModel].self, from: data) {
            self.cartPets.removeAll()
            self.cartPets = pets
        }
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
