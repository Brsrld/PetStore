//
//  UpdatePetStatusEndPoints.swift
//  PetStore
//
//  Created by Brsrld on 23.08.2023.
//

import Foundation
import Alamofire
// MARK: - UpdatePetStatusEndPoints
struct UpdatePetStatusEndPoints: Endpoint  {
    let petModel: UpdatePetModel
    let id: String
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
    
    var path: String {
        return "/v2/pet/\(id)"
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    var body: [String : Any]? {
        return petModel.dictionary
    }
}
