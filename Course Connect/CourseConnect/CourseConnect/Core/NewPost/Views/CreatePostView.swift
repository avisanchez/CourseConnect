//
//  CreatePost.swift
//  CourseConnect
//
//  Created by Avi Sanchez on 7/29/22.
//

import SwiftUI

struct CreatePostView: View {
    
    
    @Binding var newPost: UnpublishedPost
    @Binding var postProcessComplete: Bool
    @Binding var forceDismissView: Bool
    
    
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var postImages: [UIImage] = []
    
    @State private var contentType = "text"
    

    init(newPost: Binding<UnpublishedPost>, postProcessComplete: Binding<Bool>, forceDismissView: Binding<Bool>) {
        _newPost = newPost
        _postProcessComplete = postProcessComplete
        _forceDismissView = forceDismissView
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        
        ZStack {
            Color.theme.blue.ignoresSafeArea()
            
            
            // account for clipped shape background color
            VStack {
                Spacer()
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(Color.theme.whiteOff)
                    .ignoresSafeArea()
            }
            
            VStack {
                Spacer()
                

                ScrollView {
                    VStack(alignment: .leading) {
                        
                        pageHeader
                        
                        titleEntry

                        contentEntry
                        
                        courseSelectButton
                        

                        Spacer()
                        
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 50)
                }
                .background(Color.theme.whiteOff.ignoresSafeArea())
                .clipShape(RoundedRectangle(cornerRadius: 15))
            }
            .onTapGesture {
                hideKeyboard()
            }
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
            ImagePicker(selectedImage: $selectedImage)
                .ignoresSafeArea(.keyboard)
        }
        
    }
}

extension CreatePostView {
    
    var pageHeader: some View {
        HStack {
            Text("Create Post")
                .font(.title.bold())
                .foregroundColor(Color.theme.blueDark)
            Spacer()
            Button {
                forceDismissView = true
            } label: {
                Image(systemName: "xmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.theme.blueDark)
                    
            }
        }
        .padding(.trailing)
    }
    
    var titleEntry: some View {
        VStack(alignment: .leading) {
            Text("Title")
                .font(.title2.bold())
                .foregroundColor(Color.theme.blueDark)
            
            
            TextEditor(text: $newPost.title)
                .font(.headline.bold())
                .cornerRadius(10)
                .foregroundColor(Color.theme.black)
                .background(Color.theme.white)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .frame(height: 80)
                .padding(.top, 5)
            
        }
        .padding(.top, 30)
    }
    
    var contentEntry: some View {
        VStack(alignment: .leading) {
            
            HStack(spacing: 20) {
                Text("Content")
                .font(.title2.bold())
                .foregroundColor(Color.theme.blueDark)
                
                Capsule()
                    .frame(width: 100)
                    .foregroundColor(Color.theme.white)
                    .overlay(
                        
                        ZStack {
                            HStack {
                                
                                Button {
                                    withAnimation(.spring()) {
                                        contentType = "text"
                                        newPost.selectedContent = contentType
                                    }
                                    
                                } label: {
                                    Image(systemName: "pencil")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 15, height: 15)
                                        .padding(.leading)
                                        .foregroundColor(Color.theme.black)
                                }
                                
                                
                                Spacer()
                                
                                Button {
                                    withAnimation(.spring()) {
                                        contentType = "image"
                                        newPost.selectedContent = contentType
                                    }
                                } label: {
                                    Image(systemName: "photo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20, height: 20)
                                        .padding(.trailing)
                                        .foregroundColor(Color.theme.black)
                                }
                                
                            }
                            HStack {
                                
                                if (contentType == "image") {
                                    Spacer()
                                }
                                Capsule()
                                    .frame(width: 50)
                                    .foregroundColor(Color.theme.red.opacity(0.6))
                                
                                if (contentType == "text") {
                                    Spacer()
                                }
                            
                            }
                            
                        }
                            
                    )
            }
            
            if contentType == "text" {
                TextEditor(text: $newPost.content_txt)
                    .cornerRadius(10)
                    .foregroundColor(Color.theme.black)
                    .background(Color.theme.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .frame(height: 180)
                    .padding(.top, 5)
            }
            else if contentType == "image" {
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack {
                        
                        ForEach(postImages.indices, id: \.self) { index in
                            
                        }
                        
                        ForEach(postImages.indices, id: \.self) { index in
                                                        
                            if let image = postImages[index] {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 180, height: 180)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                    .overlay(
                                        VStack {
                                            HStack {
                                                Spacer()
                                                Button {
                                                    withAnimation(.spring()) {
                                                        for i in 0..<postImages.count {
                                                            if i == index {
                                                                postImages.remove(at: i)
                                                                break
                                                            }
                                                        }
                                                    }
                                                } label: {
                                                    Image(systemName: "xmark.circle")
                                                        .foregroundColor(Color.theme.white)
                                                }
                                            }
                                            Spacer()
                                        }
                                        .padding(10)
                                    )
                                }
                        }
                        
                        if postImages.count < 3 {
                            Rectangle()
                                .stroke(Color.theme.blue.opacity(0.6), lineWidth: 3)
                                .frame(width: 180, height: 180)
                                .padding(.vertical, 5)
                                .padding(.horizontal)
                                .overlay(
                                    Image(systemName: "plus")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25, height: 25)
                                        .foregroundColor(Color.theme.black)
                                    
                                    
                                )
                                .onTapGesture {
                                    showImagePicker = true
                                }
                        }
                        
                    }
                    
                }
                    
            }

        }
        .padding(.top, 30)

    }

    
    var courseSelectButton: some View {
        HStack {
            Spacer()
            
            NavigationLink(destination: SelectCourseView(newPost: self.$newPost, postProcessComplete: self.$postProcessComplete).onAppear(perform: appendImages) ) {
                HStack {
                    Text("Next")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.theme.white)
                }
                .frame(width: 120, height: 40)
                .background(newPost.title == "" ? Color.theme.blue.opacity(0.5) : Color.theme.blue)
                .clipShape(Capsule())
            }
            .shadow(color: Color.theme.blue.opacity(0.4), radius: 3, x: 0, y: 0)
            .disabled(newPost.title == "")
            
            Spacer()
            
        }
        .padding(.top, 20)
    }
    
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        postImages.append( selectedImage )
    }
    
    func appendImages() {
        for post in postImages {
            newPost.content_img.append(post)
        }
    }
    
}



//struct NewPostView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewPostView(newPost: <#UnpublishedPost#>)
//    }
//}
