//
//  AuthenticationError.swift
//  Recipedia
//
//  Created by Pablo García López on 26/8/25.
//

import Foundation

enum AuthenticationError: LocalizedError {
    case authFailed(message: String)
    case userNotFound
    case firestoreWriteFailed(message: String)
    case firestoreReadFailed(message: String)
    case unknown

    var errorDescription: String? {
        switch self {
        case .authFailed(let message):
            return "Authentication failed: \(message)"
        case .userNotFound:
            return "User not found in Firestore."
        case .firestoreWriteFailed(let message):
            return "Failed to save user data: \(message)"
        case .firestoreReadFailed(let message):
            return "Failed to read user data: \(message)"
        case .unknown:
            return "An unknown error occurred."
        }
    }
}
