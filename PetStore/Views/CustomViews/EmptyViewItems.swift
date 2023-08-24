//
//  EmptyViewItems.swift
//  PetStore
//
//  Created by Brsrld on 23.08.2023.
//

import Foundation
import UIKit

// MARK: - ButtonType
enum ButtonType {
    case withButton
    case noButton
}

// MARK: - EmptyViewOutputProtocol
protocol EmptyViewOutputProtocol: NSObject {
    func onTappedButton()
}

// MARK: -Items
struct EmptyViewItems {
    let title: String?
    let image: String?
    let buttonName: String?
    let buttonType: ButtonType?
    weak var delegate: EmptyViewOutputProtocol?
}
