//
//  BaseViewModel.swift
//  PetStore
//
//  Created by Brsrld on 20.08.2023.
//

import Foundation
import Combine

// MARK: - BaseViewModel
class BaseViewModel<E: ViewStateProtocol> {
    @Published var states: E = .ready
    
    func changeState(_ state: E) {
        DispatchQueue.main.async { [weak self] in
            self?.states = state
            debugPrint("State changed to \(state)")
        }
    }
}
