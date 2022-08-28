//
//  CommentRowViewModel.swift
//  CourseConnect
//
//  Created by Avi Sanchez on 8/8/22.
//


import Foundation

class CommentRowViewModel: ObservableObject {
    
    @Published var comment: Comment
    private let service = PostService()
    
    
    init(comment: Comment) {
        self.comment = comment
    }
    
    
    
}
