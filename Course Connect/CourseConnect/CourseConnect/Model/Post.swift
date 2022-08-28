//
//  Post.swift
//  CourseConnect
//
//  Created by Avi Sanchez on 7/31/22.
//

import FirebaseFirestoreSwift
import Firebase
import UIKit

struct Post: Identifiable, Decodable {
    @DocumentID var id: String?
    let category: String
    let course: String
    let title: String
    var imageFolderUrl: String?
    let body: String?
    let timestamp: Timestamp
    let uid: String
    var likes: Int
    var reports: Int
    
    var user: User?
    var didLike: Bool? = false
    
}
