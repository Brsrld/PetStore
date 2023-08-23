//
//  EmptyViewItems.swift
//  PetStore
//
//  Created by Brsrld on 23.08.2023.
//

import Foundation
import UIKit

enum ButtonType {
    case withButton
    case noButton
}

protocol EmptyViewOutputProtocol: NSObject {
    func onTappedButton()
}

struct EmptyViewItems {
    let title: String?
    let image: String?
    let buttonName: String?
    let buttonType: ButtonType?
    weak var delegate: EmptyViewOutputProtocol?
}
