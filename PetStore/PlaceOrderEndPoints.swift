//
//  PlaceOrderEndPoints.swift
//  PetStore
//
//  Created by Brsrld on 22.08.2023.
//

import Foundation
import Alamofire

// MARK: - PlaceOrderEndPoints
struct PlaceOrderEndPoints: Endpoint  {
    let placeOrderModel: PlaceOrderModel
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
    
    var path: String {
        return "/v2/store/order"
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    var body: [String : Any]? {
        return placeOrderModel.dictionary
    }
}
