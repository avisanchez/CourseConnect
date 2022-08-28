//
//  NewPostFloatingButton.swift
//  CourseConnect
//
//  Created by Avi Sanchez on 7/30/22.
//

import SwiftUI

struct NewPostFloatingButton: View {
    
    @State private var showNewPostView: Bool = false
    let category: String
    let course: String
    
    var body: some View {
        Button {
            showNewPostView.toggle()
        } label: {
            Circle()
                .frame(width: 60, height: 60)
                .overlay(
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color.theme.white)
                        
                )
                .padding()
        }
        .fullScreenCover(isPresented: $showNewPostView) {
            NewPostViewFlow()
        }
    }
}

struct NewPostFloatingButton_Previews: PreviewProvider {
    static var previews: some View {
        NewPostFloatingButton(category: "english", course: "american literature")
    }
}
