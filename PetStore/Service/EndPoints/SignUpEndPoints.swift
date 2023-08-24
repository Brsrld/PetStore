//
//  SignUpEndPoints.swift
//  PetStore
//
//  Created by Brsrld on 21.08.2023.
//

import Foundation
import Alamofire

// MARK: - SignUpEndPoints
struct SignUpEndPoints: Endpoint  {
    let userModel: UserModel
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
    
    var path: String {
        return "/v2/user"
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    var body: [String : Any]? {
        return userModel.dictionary
    }
}
