//
//  GetPetEndPoints.swift
//  PetStore
//
//  Created by Brsrld on 20.08.2023.
//

import Foundation
import Alamofire


// MARK: - GetPetEndPoints
struct GetPetEndPoints: Endpoint  {
    let status: PetStatus
    
    var queryItems: [URLQueryItem]? {
        return [URLQueryItem(name: "status", value: status.rawValue)]
    }
    
    var path: String {
        return "/v2/pet/findByStatus"
    }
    
    var method: HTTPMethod {
        return .get
    }
}
