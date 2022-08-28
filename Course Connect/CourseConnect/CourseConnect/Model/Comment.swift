//
//  Comment.swift
//  CourseConnect
//
//  Created by Avi Sanchez on 8/8/22.
//

import FirebaseFirestoreSwift
import Firebase

struct Comment: Identifiable, Decodable {
    @DocumentID var id: String?
    let content: String
    let uid: String
    let pid: String
    var reports: Int
    let timestamp: Timestamp
    
    var user: User?
}
