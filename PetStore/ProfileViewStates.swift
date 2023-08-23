//
//  ProfileViewStates.swift
//  PetStore
//
//  Created by Brsrld on 23.08.2023.
//

import Foundation

enum ProfileViewStates: ViewStateProtocol {
    case ready
    case loading
    case finished
    case empty
    case logoutSuccess
    case error(error: String)
}
