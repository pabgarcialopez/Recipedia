//
//  Storage.swift
//  Recipedia
//
//  Created by Pablo García López on 30/8/25.
//

import Foundation
import FirebaseStorage

struct StorageManager {
    
    static let storageRef = Storage.storage().reference()
    
    // MARK: - Upload data
    /// Uploads data to a given path and returns the download URL.
    static func uploadData(
        _ data: Data,
        to path: String,
        contentType: String? = nil,
        completion: ((Result<String, Error>) -> Void)? = nil
    ) -> StorageUploadTask {
        
        let ref = storageRef.child(path)
        
        let metadata = StorageMetadata()
        if contentType != nil {
            metadata.contentType = contentType
        }
        
        let uploadTask = ref.putData(data, metadata: metadata) { _, error in
            if let error = error {
                completion?(.failure(error))
                return
            }
            
            ref.downloadURL { url, urlError in
                if let urlError = urlError {
                    completion?(.failure(urlError))
                } else if let url = url {
                    completion?(.success(url.absoluteString))
                } else {
                    let unexpectedError = NSError(
                        domain: "StorageManager",
                        code: -1,
                        userInfo: [NSLocalizedDescriptionKey: "URL is nil after successful upload."]
                    )
                    completion?(.failure(unexpectedError))
                }
            }
        }
        
        return uploadTask
    }

    
    // MARK: - Download data
    static func getData(path: String,
                        maxSize: Int64 = MAX_SIZE,
                        completion: @escaping (Result<Data, Error>) -> Void) {
        let ref = storageRef.child(path)
        ref.getData(maxSize: maxSize) { data, error in
            if let error = error { completion(.failure(error)) }
            else if let data = data { completion(.success(data)) }
            else {
                let unexpectedError = NSError(
                    domain: "StorageManager",
                    code: -1,
                    userInfo: [NSLocalizedDescriptionKey: "No data returned from Storage."]
                )
                completion(.failure(unexpectedError))
            }
        }
    }
    
    // MARK: - Delete data
    static func deleteData(path: String, completion: @escaping (Error?) -> Void) {
        let ref = storageRef.child(path)
        Task { @MainActor in
            do { try await ref.delete(); completion(nil) }
            catch { completion(error) }
        }
    }
}

