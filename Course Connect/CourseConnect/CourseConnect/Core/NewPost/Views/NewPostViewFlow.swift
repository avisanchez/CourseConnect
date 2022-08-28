//
//  NewPostViewFlow.swift
//  CourseConnect
//
//  Created by Avi Sanchez on 8/12/22.
//

import SwiftUI

struct NewPostViewFlow: View {
    
    @ObservedObject private var viewModel = UploadPostViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    @State private var newPost = UnpublishedPost()
    @State private var postProcessComplete = false
    @State private var forceDimissView = false
    
    var body: some View {
        
        NavigationView {
            CreatePostView(newPost: $newPost, postProcessComplete: $postProcessComplete, forceDismissView: $forceDimissView)
        }
        .navigationBarHidden(true)
        .onChange(of: postProcessComplete) { completed in
            if completed {
                viewModel.uploadPost(newPost: self.newPost)
            }
        }
        .onChange(of: forceDimissView) { newValue in
            presentationMode.wrappedValue.dismiss()
        }
        .onReceive(viewModel.$didUploadPost) { success in
            if success {
                presentationMode.wrappedValue.dismiss()
            }
        }
                
    }
}

struct UnpublishedPost {
    
    var category: String = ""
    var course: String = ""
    
    var title: String = ""
    var content_txt: String = ""
    var content_img: [UIImage] = []
    
    var selectedContent: String = "text" // "text" or "image"
    
}

struct NewPostViewFlow_Previews: PreviewProvider {
    static var previews: some View {
        NewPostViewFlow()
    }
}
