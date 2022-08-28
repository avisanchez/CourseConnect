//
//  PostPageView.swift
//  CourseConnect
//
//  Created by Avi Sanchez on 8/3/22.
//

import SwiftUI

struct PostPageView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var postViewModel: PostRowViewModel
    @ObservedObject var commentViewModel = UploadCommentViewModel()
    
    @State private var placeholder: String = "Add a comment"
    @State private var comment: String = ""
    @State private var isFocused: Bool = false
    
    init(post: Post) {
        self.postViewModel = PostRowViewModel(post: post)
        UITextView.appearance().backgroundColor = .clear

    }
    
    var body: some View {
        ZStack {
            
            Color.theme.whiteOff.ignoresSafeArea()
            
            ScrollView {
                LazyVStack(alignment: .leading) {
                    
                    HStack {
                        Spacer()
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            
                            Text("Post")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.theme.blueDark)
                            
                            Spacer()
                            
                            Image(systemName: "xmark")
                                .font(.title2)
                                .foregroundColor(Color.theme.blueDark)
                                .padding()
                            
                        }
                    }
                    
                    
                    
                    postView
                    
                    Text("Replies")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.theme.blueDark)
                        .padding(.top)
                    
                    
                    CommentFeedView(post: postViewModel.post)
                    
                    
                    
                    Spacer()
                }
                
            }
            .padding()
            
            commentView
            
        }
    }
}

extension PostPageView {
    var postView: some View {
        // user info + post
            VStack(alignment: .leading, spacing: 3) {
                HStack {
                    
                    VStack(alignment: .leading, spacing: 3) {
                        Text(postViewModel.post.title)
                            .font(.title2.bold())
                        
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
                .padding(.horizontal)
                .padding(.top)
                
                
                // body text
                if let body = postViewModel.post.body {
                    Text(body)
                        .opacity(0.6)
                        .padding(.top, 3)
                        .padding(.horizontal)
                } else {
                    // do image stuff here
                }
                
                
                HStack(spacing: 20) {
                    HStack {
                        
                        Image(systemName: "hand.thumbsup")
                  
                        Text("0")
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
                .padding(.vertical, 15)
                .padding(.horizontal)
                
            }
            .background(Color.theme.white)
            .foregroundColor(Color.theme.blueDark)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .navigationBarHidden(true)
    }
    
    var commentView: some View {
        VStack {
            Spacer()
            
            VStack(alignment: .trailing, spacing: 0) {
                
                if isFocused {
                    HStack {
                        Button {
                            
                            hideKeyboard()
                            isFocused = false
                            
                        } label: {
                            Image(systemName: "xmark")
                        }
                        
                        
                        Text("Please follow post guidelines")
                            .font(.callout)
                        
                        Spacer()
                    }
                    .foregroundColor(Color.theme.black)
                    .padding()
                    
                    
                    Divider()
                }
                
                ZStack {
                    
                    TextEditor(text: isFocused ? $comment : $placeholder)
                        .foregroundColor(isFocused ? Color.theme.black : Color.theme.black.opacity(0.8))
                        .frame(maxWidth: .infinity, maxHeight: isFocused ? 100 : 30)
                        .padding(.bottom, 5)
                        .padding(.horizontal, 5)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .padding(.horizontal)
                        .onTapGesture {
                            
                                withAnimation(.spring()) {
                                    isFocused = true
                                }
                            
                        }
                    
                    if isFocused && comment == "" {
                        TextEditor(text: $placeholder)
                            .foregroundColor(Color.theme.black.opacity(0.8))
                            .frame(maxWidth: .infinity, maxHeight: 100)
                            .padding(.bottom, 5)
                            .padding(.horizontal, 5)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .padding(.horizontal)
                            .opacity(0.1)
                            .disabled(true)
                    }
                    
                }
                
                
                if isFocused {
                    Divider()
                    Button {
                        commentViewModel.uploadComment(underPost: postViewModel.post, withBody: comment)
                        isFocused = false
                        hideKeyboard()
                        comment = ""
                    } label: {
                        Text("Reply")
                            .fontWeight(.medium)
                            .foregroundColor(comment == "" ? Color.theme.blue.opacity(0.4) : Color.theme.blue)
                            .padding()
                    }
                    .disabled(comment == "")
                    
                }
                
                
            }
            .background(Color.theme.white)
            
        }
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

//struct PostPageView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostPageView()
//    }
//}
