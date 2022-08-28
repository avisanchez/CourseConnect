//
//  FeedViewModel.swift
//  CourseConnect
//
//  Created by Avi Sanchez on 7/31/22.
//

import Foundation

class PostFeedViewModel: ObservableObject {
    @Published var posts = [Post]()
    let service = PostService()
    let userService = UserService()
    
    

    init() {
        fetchPosts()
    }
    
    func fetchPosts() {
        service.fetchPosts { posts in
            self.posts = posts
            
            posts.forEach { post in
                
                for i in 0..<posts.count {
                    let uid = posts[i].uid
                    
                    self.userService.fetchUser(withUid: uid) { user in
                        self.posts[i].user = user
                    }
                }
                
            }
        }
    }
}
