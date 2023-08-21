//
//  SignUpServiceable.swift
//  PetStore
//
//  Created by Brsrld on 21.08.2023.
//

import Foundation
import Alamofire

protocol SignUpServiceable {
    func signUp(userModel: UserModel) async -> Result<UserResponseModel, Alamofire.AFError>
}

struct SignUpService: HTTPClient, SignUpServiceable {
    func signUp(userModel: UserModel) async -> Result<UserResponseModel, Alamofire.AFError> {
        return await sendRequest(endpoint: SignUpEndPoints(userModel: userModel), responseModel: UserResponseModel.self)
    }
}
