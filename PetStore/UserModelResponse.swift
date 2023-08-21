//
//  UserModelResponse.swift
//  PetStore
//
//  Created by Brsrld on 21.08.2023.
//

import Foundation

// MARK: - UserREsponseModel
struct UserResponseModel: Decodable {
    let code: Int?
    let type: String?
    let message: String?
}
