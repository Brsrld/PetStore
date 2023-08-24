//
//  CartServiceable.swift
//  PetStore
//
//  Created by Brsrld on 22.08.2023.
//

import Foundation
import Alamofire

// MARK: - CartServiceable
protocol CartServiceable {
    func placeOrder(placeOrderModel: PlaceOrderModel) async -> Result<UserResponseModel, Alamofire.AFError>
}

// MARK: - CartService
struct CartService: HTTPClient, CartServiceable {
    func placeOrder(placeOrderModel: PlaceOrderModel) async -> Result<UserResponseModel, Alamofire.AFError> {
        return await sendRequest(endpoint: PlaceOrderEndPoints(placeOrderModel: placeOrderModel), responseModel: UserResponseModel.self)
    }
}
