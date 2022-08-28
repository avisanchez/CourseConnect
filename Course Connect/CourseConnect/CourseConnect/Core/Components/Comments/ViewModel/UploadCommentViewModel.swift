//
//  CommentRowViewModel.swift
//  CourseConnect
//
//  Created by Avi Sanchez on 8/8/22.
//

import Foundation

class UploadCommentViewModel: ObservableObject {
    
    @Published var didUploadComment = false
    let service = PostService()
    
    func uploadComment(underPost post: Post, withBody content: String) {
        
        service.uploadComment(underPost: post, content: content) { success in
            if success {
                self.didUploadComment = true
            } else {
                // show error message to user...
            }
        }

    }
    
}
