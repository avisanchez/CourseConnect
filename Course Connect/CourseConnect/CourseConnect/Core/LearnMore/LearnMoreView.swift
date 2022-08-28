//
//  LearnMoreView.swift
//  CourseConnect
//
//  Created by Avi Sanchez on 7/28/22.
//

import SwiftUI

struct LearnMoreView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            
            headerView
            
            
            
            LazyVStack(alignment: .leading, spacing: 15) {
                
                aboutView
                
                inspirationView
               
                anonymityView

                
            }
            .padding(.leading, 20)
            .padding(.trailing, 18)
        }
        .background(Color.theme.whiteOff)
        .foregroundColor(Color.theme.black)
        .navigationBarHidden(true)

    }
    

}

extension LearnMoreView {
    var headerView: some View {
        ZStack {
            HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.theme.black)
                }
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top)
            
            HStack {
                Spacer()
                Text("Learn more")
                    .font(.title3)
                    .fontWeight(.medium)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top)
        }

    }
    
    var aboutView: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("About")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.top)
            
            Text("\tCourseConnect is an app designed to foster student collaboration in a variety of academic subjects. It was create specifically for the MVLA district, with discussion threads relevant to classes offered in local high schools.")
                .lineSpacing(12)
        }
    }
    
    var inspirationView: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Inspiration")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.top)
            
            Text("\tCourseConnect was created in response to a lack of student centered forum and chat applications online. By focusing discussions purely on academics and relevant classe topics, CourseConnect provides a necessary way to learn and collaborate outside of the classroom.")
                .lineSpacing(12)
        }
    }
    
    var anonymityView: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Anonymity")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.top)
            
            Text("\tCourseConnect allows users to maintain privacy through anonymous posting and browsing. This feature was implemented to eliminate the all-too-common fear of asking\n a 'wrong' or 'dumb' question: an obstacle which prevents many students from seeking help in class. ADD SOMETHING HERE LATER. The ability to report posts alongisde feed moderation ensures that discussions will not lose relevance ")
                .lineSpacing(12)
        }
    }
}

struct LearnMoreView_Previews: PreviewProvider {
    static var previews: some View {
        LearnMoreView()
    }
}
