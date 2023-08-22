//
//  CartViewModel.swift
//  PetStore
//
//  Created by Brsrld on 22.08.2023.
//

import Foundation

protocol CartViewModelProtocol {
    var statePublisher: Published<CartViewStates>.Publisher { get }
    var cartPets: [PetModel] { get set }
    var petID: Int? { get set }
    func readData()
    func placeOrder() 
}

final class CartViewModel: BaseViewModel<CartViewStates> {
    private let service: CartServiceable
    var cartPets: [PetModel] = []
    var petID: Int?
    
    init(service: CartServiceable) {
        self.service = service
    }
    
    private func currentDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY, MMM d, HH:mm:ss"
        return dateFormatter.string(from: date)
    }
    
    func readData() {
        if let data = UserDefaults.standard.object(forKey: "cartsData") as? Data,
           let pets = try? JSONDecoder().decode([PetModel].self, from: data) {
            self.cartPets = pets
        } else {
            changeState(.empty)
        }
    }
    
    private func removeOrderedPets() {
        cartPets = cartPets.filter { $0.id != petID }
        UserDefaults.standard.set(cartPets.encode(), forKey: "cartsData")
    }
    
    func placeOrder() {
        let body = PlaceOrderModel(id: 0,
                                   petID: petID,
                                   quantity: 1,
                                   shipDate: currentDate(),
                                   status: "placed",
                                   complete: true)
        changeState(.loading)
        Task { [weak self] in
            guard let self = self else { return }
            let result = await self.service.placeOrder(placeOrderModel: body)
            self.changeState(.finished)
            switch result {
            case .success(_):
                self.changeState(.success)
                removeOrderedPets()
            case .failure(let failure):
                self.changeState(.error(error: failure.localizedDescription))
            }
        }
    }
}

// MARK: - HomeViewModelProtocol
extension CartViewModel: CartViewModelProtocol {
    var statePublisher: Published<CartViewStates>.Publisher {
        $states
    }
}
