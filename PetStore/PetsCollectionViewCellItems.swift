//
//  PetsCollectionViewCellItems.swift
//  PetStore
//
//  Created by Brsrld on 20.08.2023.
//

import Foundation

protocol PetsCollectionViewCellOutputProtocol: NSObject {
    func onTappedButton(indexPath: Int?)
}

struct PetsCollectionViewCellItems {
    let title: String?
    let image: String?
    let status: PetStatus?
    let indexPath: Int?
    weak var delegate: PetsCollectionViewCellOutputProtocol?
}
