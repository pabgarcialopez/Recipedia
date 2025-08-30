//
//  Storage.swift
//  Recipedia
//
//  Created by Pablo García López on 30/8/25.
//

import Foundation
import FirebaseStorage

let storageRef = Storage.storage().reference()

enum DataUploadError: LocalizedError {
    case urlIsNil
    case putData(message: String)
    case downloadURL(message: String)
    case unknown

    var errorDescription: String? {
        switch self {
        case .putData(let message):
            return "Upload task error: \(message)"
        case .urlIsNil:
            return "Returned URL is nil."
        case .downloadURL(message: let message):
            return "Error when downloading URL: \(message)"
        case .unknown:
            return "An unknown error occurred."
        }
    }
}

func deleteData(path: String, completion: @escaping ((any Error)?) -> Void) {
    let deletionRef = storageRef.child(path)
    Task { @MainActor in // To make deletion in main thread. Necessary.
        do {
            try await deletionRef.delete()
        } catch {
            completion(error)
        }
    }
}

func uploadData(
    _ data: Data,
    to path: String,
    metadata: StorageMetadata? = nil,
    completion: @escaping (Result<String, Error>) -> Void)
-> StorageUploadTask {
    
    let dataRef = storageRef.child(path)
    
    // Upload task is returned.
    return dataRef.putData(data, metadata: metadata) { metadata, error in
        
        if let error = error {
            completion(.failure(error))
        }
        
        dataRef.downloadURL { url, urlError in
        
            if let urlError = urlError {
                completion(.failure(urlError))
                return
            }
            
            guard let url = url else {
                print("URL is nil in uploadData.")
                return
            }
            
            completion(.success(url.absoluteString))
        }
    }
}
