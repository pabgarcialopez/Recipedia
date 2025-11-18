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
    @Published var isLoading: Bool
    
    private let authenticationRepository: AuthenticationRepository
    
    init(authenticationRepository: AuthenticationRepository = AuthenticationRepository()) {
        self.authenticationRepository = authenticationRepository
        self.isLoading = false
        getCurrentUser()
    }
    
    func getCurrentUser() {
        authenticationRepository.getCurrentUser { user in
            self.user = user
        }
    }
    
    func createNewUser(email: String, password: String) {
        isLoading = true
        authenticationRepository.createNewUser(email: email, password: password) { [weak self] result in
            self?.isLoading = false
            switch result {
                case .success(let user):
                    self?.user = user
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
            }
        }
    }
    
    func signIn(email: String, password: String) {
        isLoading = true
        authenticationRepository.signIn(email: email, password: password) { [weak self] result in
            self?.isLoading = false
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
    
    func updateEmail(to newEmail: String, completion: @escaping (Result<String, Error>) -> Void) {
        authenticationRepository.updateEmail(to: newEmail, completion: completion)
    }
    
    func updatePassword(from currentPassword: String, to newPassword: String, completion: @escaping (Result<String, Error>) -> Void) {
        authenticationRepository.updatePassword(from: currentPassword, to: newPassword, completion: completion)
    }
}
