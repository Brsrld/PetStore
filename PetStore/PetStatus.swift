//
//  PetStatus.swift
//  PetStore
//
//  Created by Brsrld on 20.08.2023.
//

import Foundation

// MARK: - PetStatus

enum PetStatus: String, CaseIterable {
    case available = "available"
    case pending = "pending"
    case sold =  "sold"
    case placed = "placed"
}
