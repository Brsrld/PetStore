//
//  BaseViewStates.swift
//  PetStore
//
//  Created by Brsrld on 20.08.2023.
//

import Foundation

// MARK: - ViewStateProtocol
protocol ViewStateProtocol {
    static var ready: Self { get }
}

// MARK: - ViewStatable
protocol ViewStatable {
    associatedtype ViewState: ViewStatable = DefaultViewState
}

// MARK: - DefaultViewState
enum DefaultViewState: ViewStateProtocol {
    case ready
}
