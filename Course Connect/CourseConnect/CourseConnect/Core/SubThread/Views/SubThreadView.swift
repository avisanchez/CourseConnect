//
//  FeedPageView.swift
//  CourseConnect
//
//  Created by Avi Sanchez on 7/26/22.
//

import SwiftUI

struct SubThreadView: View {
    
    let category: String
    let course: String
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    
                    HStack {
                        Text(course)
                            .font(.title.bold())
                        Spacer()
                    }
                    .padding(20)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: 100)
                .background(
                    Color(red: 0.9, green: 0.93, blue: 0.97)
                        .cornerRadius(10)
                        .blur(radius:10, opaque: false)
                        .ignoresSafeArea(.all, edges: .top)
                )
                                
                Spacer()
            }
            
           
        }
        .background(Color.theme.whiteOff)
    }
}

struct SubThreadView_Previews: PreviewProvider {
    static var previews: some View {
        SubThreadView(category: "english", course: "american literature")
    }
}
