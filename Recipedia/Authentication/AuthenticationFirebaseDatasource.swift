//
//  AuthenticationFirebaseDatasource.swift
//  Recipedia
//
//  Created by Pablo García López on 25/8/25.
//

import Foundation
import FirebaseAuth

struct User {
    let email: String
}

final class AuthenticationFirebaseDatasource {
    
    func getCurrentUser() -> User? {
        guard let email = Auth.auth().currentUser?.email else { return nil }
        return .init(email: email)
    }
    
    
    func createNewUser(email: String, password: String, completionBlock: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            
            if let error = error {
                print("Error creating a new user \(error.localizedDescription)")
                completionBlock(.failure(error))
                return
            }
            
            let email = result?.user.email ?? "No email"
            print("New user created with info \(email)")
            completionBlock(.success(.init(email: email)))
        }
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
        
    }
}
