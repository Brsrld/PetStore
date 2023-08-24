//
//  SignInEndPoints.swift
//  PetStore
//
//  Created by Brsrld on 22.08.2023.
//

import Foundation
import Alamofire

// MARK: - SignInEndPoints
struct SignInEndPoints: Endpoint  {
    let userName: String
    let password: String
    
    var queryItems: [URLQueryItem]? {
        return [URLQueryItem(name: "username", value: userName),
                URLQueryItem(name: "password", value: password)]
    }
    
    var path: String {
        return "/v2/user/login"
    }
    
    var method: HTTPMethod {
        return .get
    }
}
