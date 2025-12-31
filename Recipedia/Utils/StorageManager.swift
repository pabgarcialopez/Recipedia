//
//  Storage.swift
//  Recipedia
//
//  Created by Pablo García López on 30/8/25.
//

import Foundation
import FirebaseStorage

struct StorageManager {
    
    let storageRef = Storage.storage().reference()
    
    func getData(path: String, completion: @escaping (Result<Data?, any Error>) -> Void) {
        let getterRef = storageRef.child(path)
        
        getterRef.getData(maxSize: MAX_SIZE) { data, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(data))
            }
        }
    }
    
    func uploadData(
        _ data: Data,
        to path: String,
        metadata: StorageMetadata? = nil,
        completion: @escaping (Result<String, any Error>) -> Void
    ) -> StorageUploadTask {
        
        let dataRef = storageRef.child(path)
        
        // Upload task is returned so the caller can observe progress or cancel if needed
        let uploadTask = dataRef.putData(data, metadata: metadata) { metadata, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Retrieve the download URL once upload completes successfully
            dataRef.downloadURL { url, urlError in
                
                if let urlError = urlError {
                    completion(.failure(urlError))
                    return
                }
                
                guard let url = url else {
                    let unexpectedError = NSError(
                        domain: "UploadData",
                        code: -1,
                        userInfo: [NSLocalizedDescriptionKey: "URL is nil after successful upload."]
                    )
                    completion(.failure(unexpectedError))
                    return
                }
                
                // Return the actual download URL string
                completion(.success(url.absoluteString))
            }
        }
        
        return uploadTask
    }
    
    
    
    func deleteData(path: String, completion: @escaping ((any Error)?) -> Void) {
        let deletionRef = storageRef.child(path)
        Task { @MainActor in // To make deletion in main thread. Necessary.
            do {
                try await deletionRef.delete()
                completion(nil)
            } catch {
                completion(error)
            }
        }
    }
}

