//
//  LogoutEndPoints.swift
//  PetStore
//
//  Created by Brsrld on 23.08.2023.
//

import Foundation
import Alamofire

// MARK: - LogoutEndPoints
struct LogoutEndPoints: Endpoint  {
 
    var path: String {
        return "/v2/user/logout"
    }
    
    var method: HTTPMethod {
        return .get
    }
}
