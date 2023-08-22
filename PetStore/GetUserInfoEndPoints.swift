//
//  GetUserInfoEndPoints.swift
//  PetStore
//
//  Created by Brsrld on 23.08.2023.
//

import Foundation
import Alamofire

// MARK: - GetUserInfoEndPoints
struct GetUserInfoEndPoints: Endpoint  {
    let userName: String
 
    var path: String {
        return "/v2/user/\(userName)"
    }
    
    var method: HTTPMethod {
        return .get
    }
}
