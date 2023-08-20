//
//  PetsCollectionViewCellItems.swift
//  PetStore
//
//  Created by Brsrld on 20.08.2023.
//

import Foundation

protocol PetsCollectionViewCellOutputProtocol: NSObject {
    func onTappedButton()
}

struct PetsCollectionViewCellItems {
    let title: String
    let image: String
    weak var delegate: PetsCollectionViewCellOutputProtocol?
}
