//
//  BaseViewStates.swift
//  PetStore
//
//  Created by Brsrld on 20.08.2023.
//

import Foundation

protocol ViewStateProtocol {
    static var ready: Self { get }
}

protocol ViewStatable {
    associatedtype ViewState: ViewStatable = DefaultViewState
}

enum DefaultViewState: ViewStateProtocol {
    case ready
}
