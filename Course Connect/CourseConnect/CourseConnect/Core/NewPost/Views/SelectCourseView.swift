//
//  CourseSelectView.swift
//  CourseConnect
//
//  Created by Avi Sanchez on 8/4/22.
//

import SwiftUI

struct SelectCourseView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var newPost: UnpublishedPost
    @Binding var postProcessComplete: Bool
    
    typealias CourseInfo = (category: String, course: String)
    
    @State private var searchText: String = ""
    @State private var currentCourse: String = ""

    
    init(newPost:Binding<UnpublishedPost>, postProcessComplete: Binding<Bool>) {
        _newPost = newPost
        _postProcessComplete = postProcessComplete
        UITableView.appearance().backgroundColor = UIColor(Color.clear)
    }
        
    var body: some View {
        
        NavigationView {
            List {
                ForEach(courses, id: \.course) { bundle in
                    
                    NavigationLink(destination: SubmitPostView(postProcessComplete: self.$postProcessComplete, newPost: self.$newPost).onAppear(perform: {
                        newPost.category = bundle.category
                        newPost.course = bundle.course
                    }) ) {
                        HStack {
                            Text(bundle.course)
                                .fontWeight(.medium)
                                .foregroundColor(Color.theme.black)
                            
                            Spacer()
                        }
                    }
                    
                    
                }
            }
            .background(Color.theme.white)
            .foregroundColor(Color.theme.red)
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
                
                ToolbarItem(placement: .principal) {
                    Text("Find a class")
                        .fontWeight(.bold)
                        .foregroundColor(Color.theme.black)
                }
            }
            .searchable(text: $searchText)
            .disableAutocorrection(true)
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationBarHidden(true)

    }
    
    var courses: [CourseInfo] {
        
        // [ (category, course) ]
        var lcCourseList: [CourseInfo] = []
        
        for categoryDict in masterCourseDictionary {
            for courseDict in categoryDict.value {
                lcCourseList.append( (categoryDict.key, courseDict.key) )
            }
        }
    
        return searchText == "" ? [] : lcCourseList.filter { bundle in
            bundle.course.lowercased().contains( searchText.lowercased() )
        }
        
    }
}

//struct CourseSelectView_Previews: PreviewProvider {
//    static var previews: some View {
//        CourseSelectView()
//    }
//}
