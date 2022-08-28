//
//  User.swift
//  CourseConnect
//
//  Created by Avi Sanchez on 7/28/22.
//

import FirebaseFirestoreSwift

struct User: Identifiable, Decodable {
    @DocumentID var id: String?
    let email: String
    let fullname: String
    let school: String
    let grade: String
}
