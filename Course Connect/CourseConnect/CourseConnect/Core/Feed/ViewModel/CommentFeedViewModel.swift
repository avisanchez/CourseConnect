//
//  CommentFeedViewModel.swift
//  CourseConnect
//
//  Created by Avi Sanchez on 8/8/22.
//

import Foundation

class CommentFeedViewModel: ObservableObject {
    @Published var comments = [Comment]()
    let service = PostService()
    let userService = UserService()
    
    let post: Post
    
    

    init(post: Post) {
        self.post = post
        fetchComments()
    }
    
    func fetchComments() {
        service.fetchComments(forPost: self.post, completion: { comments in
            self.comments = comments
        })
    }
}
