//
//  UploadPostViewModel.swift
//  CourseConnect
//
//  Created by Avi Sanchez on 7/30/22.
//

import Foundation
import UIKit

class UploadPostViewModel: ObservableObject {
    @Published var didUploadPost = false
    let service = PostService()
    
    func uploadPost(newPost: UnpublishedPost) {
        
        if newPost.selectedContent == "text" {
            service.uploadPost(category: newPost.category, course: newPost.course, title: newPost.title, body: newPost.content_txt) { success in
                if success {
                    self.didUploadPost = true
                } else {
                    // show error message to user...
                }
            }
        }

        
        else if newPost.selectedContent == "image" {
            
            service.uploadPost(category: newPost.category, course: newPost.course, title: newPost.title, images: newPost.content_img) { success in
                if success {
                    self.didUploadPost = true
                } else {
                    // show error message to user...
                }
            }
        }
        
        
    }
}
