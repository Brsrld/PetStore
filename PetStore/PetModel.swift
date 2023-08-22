//
//  PetModel.swift
//  PetStore
//
//  Created by Brsrld on 20.08.2023.
//

import Foundation

// MARK: - PetModel
struct PetModel: Codable {
    let id: Int?
    let category: Category?
    let name: String?
    let photoUrls: [String]?
    let tags: [Category]?
    let status: String?
    var quantitiy: Int?
}

// MARK: - Category
struct Category: Codable {
    let id: Int?
    let name: String?
}
