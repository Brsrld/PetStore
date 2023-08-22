//
//  Endpoint.swift
//  PetStore
//
//  Created by Brsrld on 20.08.2023.
//

import Foundation
import Alamofire

// MARK: - Endpoint
protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var header: HTTPHeaders? { get }
    var body: [String: Any]? { get }
    var queryItems: [URLQueryItem]? { get }
}

// MARK: - Endpoint Extension
extension Endpoint {
    var scheme: String {
        return "https"
    }

    var host: String {
        return "petstore.swagger.io"
    }
    
    var body: [String: Any]? {
        return ["":""]
    }
    
    var queryItems: [URLQueryItem]?  {
        return nil
    }
    
    var header: HTTPHeaders? {
        return .default
    }
}
