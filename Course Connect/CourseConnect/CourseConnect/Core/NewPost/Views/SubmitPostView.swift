//
//  FinalNewPostView.swift
//  CourseConnect
//
//  Created by Avi Sanchez on 8/6/22.
//

import SwiftUI

struct SubmitPostView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var postProcessComplete: Bool
    @Binding var newPost: UnpublishedPost
    

    
    let courseImages = ["English" : "book", "Math" : "function", "Science" : "atom", "Social Studies" : "building.columns", "World Languages" : "globe.americas"]
    
    var body: some View {
        
            VStack(alignment: .leading) {
                
                HStack {
                    Text(newPost.course)
                    
                    Spacer()
                }
                
                VStack(alignment: .leading) {
                    
                    HStack {
                        Text(newPost.title)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                            .foregroundColor(Color.theme.black)
                        
                        Spacer()
                    }
                    
                    HStack {
                        if newPost.selectedContent == "text" {
                            
                            Text(newPost.content_txt)
                                .padding(.horizontal)
                                .padding(.bottom)
                                .padding(.top, 5)
                                .foregroundColor(Color.theme.black)
                            
                        } else if newPost.selectedContent == "image" {
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack {
                                    ForEach(newPost.content_img.indices, id: \.self) { index in
                                        
                                        Image(uiImage: newPost.content_img[index])
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 180, height: 180)
                                            .clipShape(RoundedRectangle(cornerRadius: 5))
                                    }
                                }
                            }
                            .frame(maxHeight: 180)
                            .padding(.horizontal)
                            .padding(.bottom)
                            
                            
                        }
        
                        
                        Spacer()
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.top)
                .foregroundColor(Color.theme.black)
                .background(Color.theme.whiteOff)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                
                
                Spacer()
            }
            .padding()
            .background(Color.theme.white)
            .toolbar {

                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "chevron.left")

                            Text("Back")
                        }
                        .foregroundColor(Color.theme.black)

                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    Button {
                        postProcessComplete = true
                    } label: {
                        Text("Post")
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                            .foregroundColor(Color.theme.white)
                            .background(Color.theme.blue)
                            .clipShape(Capsule())
                    }
                    
                }

                
                ToolbarItem(placement: .principal) {
                    Image(systemName: courseImages[newPost.category] ?? "")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color.theme.black)
                }
            }
            .navigationBarBackButtonHidden(true)
        
    }
}

//struct FinalNewPostView_Previews: PreviewProvider {
//    static var previews: some View {
//        FinalNewPostView(category: <#T##String#>, course: <#T##String#>, title: <#T##String#>, content: <#T##String#>)
//    }
//}
