////
////  CourseSearchView.swift
////  CourseConnect
////
////  Created by Avi Sanchez on 7/30/22.
////
//
//import SwiftUI
//
//struct CourseSearchView: View {
//    
//    let courseList = masterCourseList
//    @State var searchText: String = ""
//    @State var currentCourse: String = ""
//    
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(names, id: \.self) { course in
//                    
//                    Button {
//                        currentCourse = course
//                        print(currentCourse)
//                    } label: {
//                        HStack {
//                            Text(course)
//                                .fontWeight(.medium)
//                            Spacer()
//                           
//                        }
//                    }
//                    
//                    
//                }
//            }
//            .searchable(text: $searchText)
//            .navigationTitle("Names")
//        }
//        .navigationBarHidden(true)
//        
//    }
//        
//    
//    var names: [String] {
//        let lcCourseList = courseList.map { $0.lowercased() }
//        
//        return searchText == "" ? lcCourseList : lcCourseList.filter {
//            $0.contains(searchText.lowercased())
//        }
//    }
//}
//
//struct CourseSearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        CourseSearchView()
//    }
//}
