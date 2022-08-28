//
//  ImageUploader.swift
//  CourseConnect
//
//  Created by Avi Sanchez on 8/9/22.
//

import UIKit
import SwiftUI
import Firebase
import FirebaseStorage

struct ImageUploader {
    
    static func uploadImage(forPostID postID: String, withImages images: [UIImage]) {

        
        // create 1 unique folder for all
        let folderRef = UUID().uuidString
        
        for image in images {
            guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
            
            let storageRef = Storage.storage().reference()
            
            let path = "images/posts/\(folderRef)/\(UUID().uuidString).jpg"
            
            let fileRef = storageRef.child(path)
            
            // upload folder reference to post document
            fileRef.putData(imageData, metadata: nil) { metadata, error in
                if error == nil && metadata != nil {
                    print("DEBUG: Uploaded image successfully")
                }
                else if let error = error {
                    print("DEBUG: failed to upload images with error: \(error.localizedDescription)")
                }
            }
        }
        
        let db = Firestore.firestore()
        db.collection("posts").document(postID).updateData(["imageFolderUrl": folderRef])

    }
    
    
}
