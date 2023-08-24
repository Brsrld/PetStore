//
//  ProfileServiceable.swift
//  PetStore
//
//  Created by Brsrld on 23.08.2023.
//

import Foundation
import Alamofire

// MARK: - CartServiceable
protocol ProfileServiceable {
    func getUserInfo(userName: String) async -> Result<UserModel, Alamofire.AFError>
    func logout() async -> Result<UserResponseModel, Alamofire.AFError>
}

// MARK: - CartService
struct ProfileService: HTTPClient, ProfileServiceable {
    func logout() async -> Result<UserResponseModel, Alamofire.AFError> {
        return await sendRequest(endpoint: LogoutEndPoints(), responseModel: UserResponseModel.self)
    }
    
    func getUserInfo(userName: String) async -> Result<UserModel, Alamofire.AFError> {
        return await sendRequest(endpoint: GetUserInfoEndPoints(userName: userName), responseModel: UserModel.self)
    }
}
