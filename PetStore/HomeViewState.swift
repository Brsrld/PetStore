//
//  HomeViewState.swift
//  PetStore
//
//  Created by Brsrld on 20.08.2023.
//

import Foundation

enum HomeViewStates: ViewStateProtocol {
    case ready
    case loading
    case finished
    case error(error: String)
    case empty
}
