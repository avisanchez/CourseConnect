//
//  ProfileViewModel.swift
//  CourseConnect
//
//  Created by Avi Sanchez on 8/2/22.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var posts = [Post]()
    @Published var likedPosts = [Post]()
    
    private let service = PostService()
    private let userService = UserService()
    let user: User
    
    init(user: User) {
        self.user = user
        self.fetchUserPosts()
        self.fetchLikedPosts()
    }
    
    func posts(forFilter filter: PostFilterViewModel) -> [Post] {
        switch filter {
        case.posts:
            return posts
        case.replies:
            return posts
        case.likes:
            return likedPosts
        }
    }
    
    func fetchUserPosts() {
        print("DEBUG: fetching user posts")
        guard let uid = user.id else { return }
        
        service.fetchPosts(forUid: uid) { posts in
            self.posts = posts
            
            for i in 0..<posts.count {
                self.posts[i].user = self.user
            }
        }
    }
    
    func fetchLikedPosts() {
        print("DEBUG: fetching liked posts")
        guard let uid = user.id else { return }
        
        service.fetchLikedPosts(forUid: uid) { posts in
            self.likedPosts = posts
            
            for i in 0..<posts.count {
                let uid = posts[i].uid
                
                self.userService.fetchUser(withUid: uid) { user in
                    self.likedPosts[i].user = user
                }
            }
        }
    }
}
