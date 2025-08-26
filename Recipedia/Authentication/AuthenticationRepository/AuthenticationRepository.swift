//
//  AuthenticationRepository.swift
//  Recipedia
//
//  Created by Pablo García López on 25/8/25.
//

import Foundation

final class AuthenticationRepository {
    private let authenticationFirebaseDatasource: AuthenticationFirebaseDatasource
    
    init(authenticationFirebaseDatasource: AuthenticationFirebaseDatasource = AuthenticationFirebaseDatasource()) {
        self.authenticationFirebaseDatasource = authenticationFirebaseDatasource
    }
    
    func getCurrentUser(completion: @escaping (User?) -> Void){
        return authenticationFirebaseDatasource.getCurrentUser(completion: completion)
    }
    
    func createNewUser(email: String, password: String, completion: @escaping (Result<User, AuthenticationError>) -> Void) {
        authenticationFirebaseDatasource.createNewUser(email: email, password: password, completion: completion)
    }
    
    func signIn(email: String, password: String, completion: @escaping (Result<User, AuthenticationError>) -> Void) {
        authenticationFirebaseDatasource.signIn(email: email, password: password, completion: completion)
    }
    
    func signOut() throws {
        try authenticationFirebaseDatasource.signOut()
    }
}
