//
//  PlaceOrderModel.swift
//  PetStore
//
//  Created by Brsrld on 22.08.2023.
//

import Foundation

// MARK: - PaceOrderModel
struct PlaceOrderModel: Codable {
    let id: Int?
    let petID: Int?
    let quantity: Int?
    let shipDate: String?
    let status: String?
    let complete: Bool?
}
