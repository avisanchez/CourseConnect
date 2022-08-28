//
//  PostRowViewModel.swift
//  CourseConnect
//
//  Created by Avi Sanchez on 8/2/22.
//

import Foundation
import UIKit


class PostRowViewModel: ObservableObject {
    
    @Published var post: Post
    //@State var images: [UIImage] = []
    private let service = PostService()
    
    
    init(post: Post) {
        self.post = post
        
        // retreive images if possible
        if let postID = post.id {
            //retrieveImages(forPostID: postID)
        }
        
        checkIfUserLikedPost()
        
      
    }
    
    func likePost() {
        service.likePost(post) {
            self.post.didLike = true
        }
    }
    
    func unlikePost() {
        service.unlikePost(post) {
            self.post.didLike = false
        }
    }
    
    func checkIfUserLikedPost() {
        service.checkIfUserLikedPost(post) { didLike in
            if didLike {
                self.post.didLike = true
            }
        }
    }
    
    func deletePost() {
        service.deletePost(post: self.post)
    }
    
    
    
}
