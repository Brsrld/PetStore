//
//  LoginViewStates.swift
//  PetStore
//
//  Created by Brsrld on 22.08.2023.
//

import Foundation

// MARK: - States
enum LoginViewStates: ViewStateProtocol {
    case ready
    case loading
    case finished
    case success
    case error(error: String)
}
