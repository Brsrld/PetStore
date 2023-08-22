//
//  SignInServiceable.swift
//  PetStore
//
//  Created by Brsrld on 22.08.2023.
//

import Foundation
import Alamofire

protocol SignInServiceable {
    func signIn(userName: String, password: String) async -> Result<UserLoginModel, Alamofire.AFError>
}

struct SignInService: HTTPClient, SignInServiceable {
    func signIn(userName: String,
                password: String) async -> Result<UserLoginModel, Alamofire.AFError> {
        
        return await sendRequest(endpoint: SignInEndPoints(userName: userName,
                                                           password: password),
                                 responseModel: UserLoginModel.self)
    }
}
