//
//  PostPreviewView.swift
//  CourseConnect
//
//  Created by Avi Sanchez on 7/26/22.
//

import SwiftUI
import Firebase
import FirebaseStorage

struct PostRowView: View {
    
    @ObservedObject private var viewModel: PostRowViewModel
    let canDelete: Bool
    @State private var showingAlert = false
    @State private var localimages: [UIImage] = []
    
    init(post: Post, removable: Bool) {
        self.viewModel = PostRowViewModel(post: post)
        self.canDelete = removable
    }
    
    var body: some View {
        
        
        
        NavigationLink(destination: PostPageView(post: viewModel.post)) {
            
        
            ZStack {
               
                // user info + post
                VStack(alignment: .leading, spacing: 3) {
                    HStack {
                        
                        
                        VStack(alignment: .leading, spacing: 3) {
                            
                            
                            Text(viewModel.post.title)
                                .font(.title2.bold())
                                .frame(height: 25)
                              
                            
                            // user info + time since post
                            HStack {
                                Text("anonymous")
                                    .fontWeight(.medium)
                                    .opacity(0.4)
                                
                                Circle()
                                    .foregroundColor(.teal)
                                    .frame(width: 5, height: 5)
                                
                                Text("1h ago")
                                    .font(.body)
                                    .fontWeight(.medium)
                                    .opacity(0.4)
                                
                                Spacer()
                            }
                        }
                        
                    }
                    
                    
                    // body text
                    if let body = viewModel.post.body {
                        Text(body)
                            .opacity(0.6)
                            .frame(height: 50)
                            .padding(.top, 3)
                    }
                    
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(localimages.indices, id: \.self) { index in

                                Image(uiImage: localimages[index])
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 300, height: 40)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                
                            }
                        }
                    }
                    
                        
                
                    
                    
                    HStack(spacing: 20) {
                        HStack {
                            Button {
                                viewModel.post.didLike ?? false ? viewModel.unlikePost() : viewModel.likePost()
                            } label: {
                                Image(systemName: viewModel.post.didLike ?? false ? "hand.thumbsup.fill" : "hand.thumbsup")
                            }
                            
                    
                            Text("\(viewModel.post.likes)")
                                .fontWeight(.medium)
                        }
                        
                        HStack {
                            Image(systemName: "bubble.right")
                            
                            Text("1")
                                .fontWeight(.medium)
                        }
                        
                        Spacer()
                        
                        HStack {
                            Image(systemName: "flag")
                            
                            Text("Report")
                                .fontWeight(.medium)
                        }
                       
                    }
                    .padding(.top, 15)
                    
                    Spacer()
                        
                }
                .padding()
                .foregroundColor(Color.theme.blueDark)
                
            }
            .frame(maxWidth: .infinity, maxHeight: 190)
            .background(Color.theme.white)
            .cornerRadius(13)
//            .onLongPressGesture {
//                print("DEBUG: Long press gesture performed")
//                if canDelete {
//                    showingAlert = true
//                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
//                }
//            }
//            .alert("Would you like to delete this post?", isPresented: $showingAlert) {
//                HStack {
//                    Button("Cancel", role: .cancel) {}
//                    Button("Delete", role: .destructive) {
//                        viewModel.deletePost()
//                    }
//                }
//                
//            }
        
        }
        .onAppear {
            if let postID = viewModel.post.id {
                retrieveImages(forPostID: postID)
            }
        }
        
        
    }
        
}

extension PostRowView {
    func retrieveImages(forPostID postID: String) {
        
        Firestore.firestore().collection("posts").document(postID).getDocument { snapshot, error in
            
            var imageFolderUrl: String
            
            if error == nil && snapshot != nil {
                imageFolderUrl = (snapshot!.get("imageFolderUrl") as! String)
                
                Storage.storage().reference(withPath: "images//posts//\(imageFolderUrl)//").listAll { results, error in
                    if error == nil && results != nil {
                        
                        if localimages.count < results!.items.count {
                            for image in results!.items {
                                image.getData(maxSize: 5 * 1024 * 1024) { data, error in
                                    if error == nil && data != nil {
                                        
                                        if let finalImage = UIImage(data: data!) {
                                            
                                            print("DEBUG: appended an image")
                                            self.localimages.append(finalImage)
                                            
                                        }
                                        
                                    }
                                }
                                
                            }

                        }
                                                
                    }
                }
            }
        }
        
        
    }
}

//struct PostRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostRowView()
//    }
//}

