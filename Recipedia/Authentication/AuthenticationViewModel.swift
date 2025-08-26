//
//  AuthenticationViewModel.swift
//  Recipedia
//
//  Created by Pablo García López on 25/8/25.
//

import Foundation

final class AuthenticationViewModel: ObservableObject {
    @Published var user: User?
    @Published var errorMessage: String?
    
    private let authenticationRepository: AuthenticationRepository
    
    init(authenticationRepository: AuthenticationRepository = AuthenticationRepository()) {
        self.authenticationRepository = authenticationRepository
        getCurrentUser()
    }
    
    func getCurrentUser() {
        authenticationRepository.getCurrentUser { user in
            self.user = user
        }
    }
    
    func createNewUser(email: String, password: String) {
        authenticationRepository.createNewUser(email: email, password: password) { [weak self] result in
            switch result {
            case .success(let user):
                self?.user = user
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
            }
        }
    }
    
    func signIn(email: String, password: String) {
        authenticationRepository.signIn(email: email, password: password) { [weak self] result in
            switch result {
            case .success(let user):
                self?.user = user
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
            }
        }
    }
    
    func signOut() {
        do {
            try authenticationRepository.signOut()
            self.user = nil
        } catch {
            print("Error while signing out: \(error)")
        }
    }
}
