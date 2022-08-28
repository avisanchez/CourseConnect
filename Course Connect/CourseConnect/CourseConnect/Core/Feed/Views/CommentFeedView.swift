//
//  CommentFeedView.swift
//  CourseConnect
//
//  Created by Avi Sanchez on 8/8/22.
//

import SwiftUI

struct CommentFeedView: View {
    @ObservedObject var viewModel: CommentFeedViewModel
    
    init(post: Post) {
        self.viewModel = CommentFeedViewModel(post: post)
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            
            ScrollView {
                ForEach(viewModel.comments) { comment in
                    CommentRowView(comment: comment)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

//struct CommentFeedView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentFeedView()
//    }
//}
