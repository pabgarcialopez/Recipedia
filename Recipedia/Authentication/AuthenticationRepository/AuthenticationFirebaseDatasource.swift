//
//  AuthenticationFirebaseDatasource.swift
//  Recipedia
//
//  Created by Pablo García López on 25/8/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class AuthenticationFirebaseDatasource {
    
    let db = Firestore.firestore()
    
    func getCurrentUser(completion: @escaping (User?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(nil)
            return
        }
        
        // Try to get user with user id "uid".
        self.db.collection(USERS_COLLECTION).document(uid).getDocument { snapshot, error in
            if let _ = error { completion(nil) }
            
            if let user = try? snapshot?.data(as: User.self) { completion(user) }
            else { completion(nil) }
        }
    }
    
    func createNewUser(email: String, password: String, completion: @escaping (Result<User, AuthenticationError>) -> Void) {
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                
                if let error = error {
                    completion(.failure(.authFailed(message: error.localizedDescription)))
                    return
                }
                
                guard let uid = result?.user.uid, let email = result?.user.email else {
                    completion(.failure(.unknown))
                    return
                }
                
                let newUser = User(id: uid, email: email)
                
                do { // Save new user to database
                    try self.db.collection(USERS_COLLECTION).document(uid).setData(from: newUser)
                    completion(.success(newUser))
                } catch {
                    completion(.failure(.firestoreWriteFailed(message: error.localizedDescription)))
                }
            }
        }
        
    func signIn(email: String, password: String, completion: @escaping (Result<User, AuthenticationError>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(.authFailed(message: error.localizedDescription)))
                return
            }
            
            guard let uid = result?.user.uid else {
                completion(.failure(.unknown))
                return
            }
            
            self.db.collection(USERS_COLLECTION).document(uid).getDocument { snapshot, error in
                if let error = error {
                    completion(.failure(.firestoreReadFailed(message: error.localizedDescription)))
                    return
                }
                
                do {
                    guard let signedInUser = try snapshot?.data(as: User.self) else {
                        completion(.failure(.firestoreReadFailed(message: "Failed to decode user data")))
                        return
                    }
                    completion(.success(signedInUser))
                    
                } catch {
                    completion(.failure(.firestoreReadFailed(message: error.localizedDescription)))
                }
            }
        }
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    func updateEmail(to newEmail: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(.failure(URLError(.userAuthenticationRequired)))
            return
        }

        Task { @MainActor in
            do {
                try await user.sendEmailVerification(beforeUpdatingEmail: newEmail)
                completion(.success("To change your email, you need to verify it first. Check your \(newEmail) inbox."))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func updatePassword(to newPassword: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(.failure(URLError(.userAuthenticationRequired)))
            return
        }
            
        user.updatePassword(to: newPassword)
        completion(.success("Password changed successfully"))
    }
}
