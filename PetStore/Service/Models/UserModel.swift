//
//  UserModel.swift
//  PetStore
//
//  Created by Brsrld on 21.08.2023.
//

import Foundation

// MARK: - UserModel
struct UserModel: Codable {
    let id: Int?
    let username: String?
    let firstName: String?
    let lastName: String?
    let email: String?
    let password: String?
    let phone: String?
    let userStatus: Int?
}
