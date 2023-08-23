//
//  ProfileViewModel.swift
//  PetStore
//
//  Created by Brsrld on 23.08.2023.
//


import Foundation

// MARK: - ProfileViewModelProtocol
protocol ProfileViewModelProtocol {
    var statePublisher: Published<ProfileViewStates>.Publisher { get }
    var userData: UserModel? { get }
    func getUserData()
    func logOut()
}

final class ProfileViewModel: BaseViewModel<ProfileViewStates> {
    
    // MARK: - Properties
    private let service: ProfileServiceable
    private let userName: String
    var userData: UserModel?
    
    // MARK: - Functions
    init(service: ProfileServiceable, userName:String) {
        self.service = service
        self.userName = userName
    }
    
    private func nilCheck() {
        if self.userData?.firstName == nil {
            changeState(.empty)
        }
    }
    
    func getUserData() {
        changeState(.loading)
        Task { [weak self] in
            guard let self = self else { return }
            let result = await self.service.getUserInfo(userName: userName)
            self.changeState(.finished)
            switch result {
            case .success(let data):
                self.userData = data
                nilCheck()
                self.changeState(.successFetchData)
            case .failure(let failure):
                self.changeState(.error(error: failure.localizedDescription))
            }
        }
    }
    
    func logOut() {
        changeState(.loading)
        Task { [weak self] in
            guard let self = self else { return }
            let result = await self.service.logout()
            self.changeState(.finished)
            switch result {
            case .success(_):
                self.changeState(.logoutSuccess)
            case .failure(let failure):
                self.changeState(.error(error: failure.localizedDescription))
            }
        }
    }
}

// MARK: - ProfileViewModelProtocol
extension ProfileViewModel: ProfileViewModelProtocol {
    var statePublisher: Published<ProfileViewStates>.Publisher {
        $states
    }
}
