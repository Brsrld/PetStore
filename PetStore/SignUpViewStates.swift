//
//  SignUpViewStates.swift
//  PetStore
//
//  Created by Brsrld on 21.08.2023.
//

import Foundation

enum SignUpViewStates: ViewStateProtocol {
    case ready
    case loading
    case finished
    case success
    case error(error: String)
    case empty
}
