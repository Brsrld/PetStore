//
//  UserLoginModel.swift
//  PetStore
//
//  Created by Brsrld on 22.08.2023.
//

import Foundation

// MARK: - UserLoginModel
struct UserLoginModel: Codable {
    let code: Int?
    let type: String?
    let message: String?
}
