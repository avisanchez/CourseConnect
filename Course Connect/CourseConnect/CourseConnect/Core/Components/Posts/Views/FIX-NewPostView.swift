////
////  NewPostView.swift
////  CourseConnect
////
////  Created by Avi Sanchez on 7/29/22.
////
//
//import SwiftUI
//
//struct NewPostView: View {
//    
//    
//    @State var titleText: String = "Edit title"
//    @State var bodyText: String = "Edit optional body text"
//    @State var showBodyTextEditor: Bool = false
//    @FocusState private var focusedField: Bool
//    
//    var body: some View {
//        ZStack {
//            
//            ScrollView(.vertical) {
//                ZStack {
//                    
//                    VStack(spacing: 0) {
//                    
//                        TextEditor(text: $titleText)
//                            .font(.title.bold())
//                            .padding(.top)
//                            .padding(.horizontal)
//                            .focused($focusedField)
//                        
//                        Spacer()
//                    }
//                    
//                    VStack {
//                        LazyVStack(spacing: 0) {
//                            
//                            titleTextShadow
//                            
//                            if showBodyTextEditor {
//                                TextEditor(text: $bodyText)
//                                    .font(.title3)
//                                    .padding(.top)
//                                    .padding(.horizontal)
//                            }
//                            
//                            Spacer()
//                        }
//                        
//                        Spacer()
//                    }
//                    
//                    
//                }
//            }
//            
//            VStack {
//                Spacer()
//                
//            
//                postMoifierButtons
//                
//            }
//            
//            
//        }
//        .navigationBarHidden(true)
//    }
//}
//
//extension NewPostView {
//    var titleTextShadow: some View {
//        HStack {
//            Text(titleText)
//                .font(.title.bold())
//                .opacity(0)
//                .padding(.top, 8)
//                .padding(.leading, 5)
//            Spacer()
//        }
//        .padding(.horizontal)
//        .padding(.top)
//    }
//    
//    var postMoifierButtons: some View {
//        RoundedRectangle(cornerRadius: 20)
//            .frame(maxWidth: .infinity, maxHeight: 90)
//            .foregroundColor(Color.theme.whiteOff)
//            .padding()
//            .ignoresSafeArea(.all, edges: .bottom)
//            .shadow(color: Color.theme.whiteOff, radius: 5, x: 0, y: 0)
//            .overlay(
//                HStack(spacing: 20) {
//                    Button {
//                        showBodyTextEditor.toggle()
//                    } label: {
//                        CustomPostLabel(title: "Text", imageName: "doc.text")
//                    }
//                    .frame(width: 130)
//                    .foregroundColor(Color.theme.blue)
//                    
//                    Button {
//                        
//                    } label: {
//                        CustomPostLabel(title: "Image", imageName: "photo")
//                    }
//                    .frame(width: 130)
//                    .foregroundColor(Color.theme.blue)
//                }
//                    
//            )
//    }
//    
//    
//}
//
//struct CustomPostLabel: View {
//    let title: String
//    let imageName: String
//    
//    var body: some View {
//        Capsule()
//            .frame(height: 40)
//            .overlay(
//                HStack {
//                    Image(systemName: imageName)
//                    Text(title)
//                        .fontWeight(.semibold)
//                
//                }
//                .foregroundColor(Color.theme.white)
//            )
//            .frame(width: 130)
//            .foregroundColor(Color.theme.blue)
//    }
//}
//
//
//struct NewPostView_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        NewPostView(titleText: "Edit title", bodyText: "Edit optional body text")
//    }
//}
