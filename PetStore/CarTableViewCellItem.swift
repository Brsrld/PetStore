//
//  CarTableViewCellItem.swift
//  PetStore
//
//  Created by Brsrld on 22.08.2023.
//

import Foundation

protocol CartTableViewCellOutputProtocol: NSObject {
    func onTappedButton(indexPath: Int?)
}

struct CarTableViewCellItem {
    let title: String?
    let image: String?
    let indexPath: Int?
    weak var delegate: CartTableViewCellOutputProtocol?
}

