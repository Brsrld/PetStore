//
//  HomeViewServiceable.swift
//  PetStore
//
//  Created by Brsrld on 20.08.2023.
//

import Foundation
import Alamofire

// MARK: - HomeViewServiceable
protocol HomeViewServiceable {
    func fetchPets(petStatus: PetStatus) async -> Result<[PetModel], AFError>
}

// MARK: - HomeViewService
struct HomeViewService: HTTPClient, HomeViewServiceable {
    func fetchPets(petStatus: PetStatus) async -> Result<[PetModel], Alamofire.AFError> {
        return await sendRequest(endpoint: GetPetEndPoints(status: petStatus), responseModel: [PetModel].self)
    }
}
