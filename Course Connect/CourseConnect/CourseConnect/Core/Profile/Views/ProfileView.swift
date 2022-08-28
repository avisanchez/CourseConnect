//
//  ProfileView.swift
//  CourseConnect
//
//  Created by Avi Sanchez on 7/28/22.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var selectedFilter: PostFilterViewModel = .posts
    @ObservedObject var viewModel: ProfileViewModel
    @Environment(\.presentationMode) var presentationMode
    @Namespace var animation
    
    init(user: User) {
        self.viewModel = ProfileViewModel(user: user)
    }


    var body: some View {
       
        VStack(alignment: .leading, spacing: 0) {
            headerView
            
            customSpacer
            
            // user info
            VStack(alignment: .leading, spacing: 5) {
                Text(viewModel.user.fullname)
                    .font(.title.bold())
                
                Text(verbatim: "\(viewModel.user.email)")
                    .opacity(0.5)
            }
            .foregroundColor(Color.theme.blueDark)
            .padding()
            
            
            filterBar
            
            // load appropriate posts
            if selectedFilter == .posts {
                ScrollView {
                    ForEach(viewModel.posts) { post in
                        PostRowView(post: post, removable: true)
                            .padding(.horizontal)
                            .padding(.top)
                    }
                }
                
            } else if selectedFilter == .likes {
                ScrollView {
                    ForEach(viewModel.likedPosts) { post in
                        PostRowView(post: post, removable: false)
                            .padding(.horizontal)
                            .padding(.top)
                    }
                }
            }
            
            Spacer()
        }
        .background(Color.theme.whiteOff)
        .navigationBarHidden(true)

    }
}

extension ProfileView {
    var headerView: some View {
        ZStack(alignment: .bottomLeading) {
            Color.theme.blue.ignoresSafeArea()
            VStack {
               Button {
                   presentationMode.wrappedValue.dismiss()
               } label: {
                   Image(systemName: "arrow.left")
                       .resizable()
                       .frame(width: 20, height: 16)
                       .foregroundColor(Color.theme.white)
                       .offset(x: 15, y: 12)
               }
               
               Circle()
                   .frame(width: 72, height: 72)
                   .offset(x: 20, y: 36)
                   .foregroundColor(Color.theme.black)
            }
            
        }
        .frame(height: 96)
    }
    
    var customSpacer: some View {
        Rectangle()
            .opacity(0)
            .frame(height: 20)
            .padding(.top)
    }
    
    var filterBar: some View {
        HStack {
            ForEach(PostFilterViewModel.allCases, id: \.rawValue) { item in
                VStack {
                    Text(item.title)
                        .font(.subheadline)
                        .fontWeight(selectedFilter == item ? .semibold : .regular)
                        .foregroundColor(selectedFilter == item ? Color.theme.black : Color.theme.gray)
                    
                    if selectedFilter == item {
                        Capsule()
                            .foregroundColor(Color.theme.blue)
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "title", in: animation)
                    } else {
                        Capsule()
                            .foregroundColor(Color.clear)
                            .frame(height: 3)
                    }
                    
                }
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        self.selectedFilter = item
                    }
                }
            }
        }
        .foregroundColor(Color.theme.white)
    }
    
    var postsView: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.posts(forFilter: self.selectedFilter)) { post in
                    PostRowView(post: post, removable: false)
                        .padding()
                }
            }
        }
    }
    
    
}


//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}
