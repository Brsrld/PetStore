//
//  CarTableViewCellItem.swift
//  PetStore
//
//  Created by Brsrld on 22.08.2023.
//

import Foundation

// MARK: - CartTableViewCellOutputProtocol
protocol CartTableViewCellOutputProtocol: NSObject {
    func onTappedButton(indexPath: Int?)
}

// MARK: - Items
struct CarTableViewCellItem {
    let title: String?
    let image: String?
    let indexPath: Int?
    weak var delegate: CartTableViewCellOutputProtocol?
}

