//
//  CommentRowView.swift
//  CourseConnect
//
//  Created by Avi Sanchez on 8/8/22.
//

import SwiftUI

struct CommentRowView: View {
    
    @ObservedObject private var viewModel: CommentRowViewModel
    
    init(comment: Comment) {
        viewModel = CommentRowViewModel(comment: comment)
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                Text("Anonymous")
                    .fontWeight(.semibold)
                
                Circle()
                    .foregroundColor(.teal)
                    .frame(width: 5, height: 5)
                
                Text("2d ago")
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top)
           
            
            Text(viewModel.comment.content)
                .padding(.horizontal)
                .padding(.bottom)
        }
        .frame(maxWidth: .infinity)
        .background(Color.theme.white)
        .cornerRadius(10)
        
        
        
        
    }
}

//struct CommentRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentRowView()
//    }
//}
