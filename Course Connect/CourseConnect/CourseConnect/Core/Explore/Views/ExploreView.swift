//
//  ExploreView.swift
//  CourseConnect
//
//  Created by Avi Sanchez on 7/31/22.
//

import SwiftUI


// View to explore different posts - search bar
import SwiftUI

struct ExploreView: View {
            
    typealias CourseInfo = (category: String, course: String)
    
    @State private var searchText: String = ""
    @State private var currentCourse: String = ""

    
    init() {
        UITableView.appearance().backgroundColor = UIColor(Color.clear)
    }
        
    var body: some View {
        
        NavigationView {
            List {
                ForEach(courses, id: \.course) { bundle in
                    
                    NavigationLink(destination: SubThreadView(category: bundle.category, course: bundle.course)) {
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
                
                ToolbarItem(placement: .principal) {
                    Text("Search for a class")
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

