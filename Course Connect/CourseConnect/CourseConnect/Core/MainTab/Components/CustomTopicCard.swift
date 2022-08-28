//
//  CustomTopicCard.swift
//  CourseConnect
//
//  Created by Avi Sanchez on 7/26/22.
//

import SwiftUI

struct CustomTopicCard: View {
    

    
    @State var courseName: String
    @State var totalPosts: Int
    @State var color: Color
    
    var body: some View {
        ZStack {
            
            
            
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(color)
                .frame(width: 150, height: 150)
                .overlay(
                    ZStack {
                        
                        Rectangle()
                            
                            .cornerRadius(15)
                            .offset(x: 70, y: 80)
                            .frame(width: 100, height: 100)
                            .foregroundColor(Color.theme.white.opacity(0.1))
                            
                            
                        
                        Rectangle()
                            .cornerRadius(15)
                            .offset(x: -80, y: -95)
                            .frame(width: 100, height: 100)
                            .foregroundColor(Color.theme.white.opacity(0.1))
                        
    
                        HStack {
                            VStack(alignment: .leading) {
                                
                                Text(courseName)
                                    .font(.title2.bold())
                                
                                Text("\(totalPosts) posts")
                                    .font(.callout)
                                    .fontWeight(.medium)
                                
                                Spacer()
                            }
                        
                            Spacer()
                        }
                        .offset(x: 10, y: 30)
                        .foregroundColor(.white)
                    }
                    .clipped()
                   
                    
                )
                .shadow(radius: 3)
        }
        
    
    }
}

struct CustomTopicCard_Previews: PreviewProvider {
    static var previews: some View {
        CustomTopicCard(courseName: "French III Honors", totalPosts: 25, color: Color.theme.purple)
    }
}
