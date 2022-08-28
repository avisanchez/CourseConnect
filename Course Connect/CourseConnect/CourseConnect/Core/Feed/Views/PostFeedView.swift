//
//  FeedView.swift
//  CourseConnect
//
//  Created by Avi Sanchez on 7/26/22.
//

import SwiftUI

struct PostFeedView: View {
    
    @ObservedObject var viewModel = PostFeedViewModel()
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            
            ScrollView {
                ForEach(viewModel.posts) { post in
                    PostRowView(post: post, removable: false)
                        .padding(.bottom, 6)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

//struct FeedView_Previews: PreviewProvider {
//    static var previews: some View {
//        FeedView()
//    }
//}
