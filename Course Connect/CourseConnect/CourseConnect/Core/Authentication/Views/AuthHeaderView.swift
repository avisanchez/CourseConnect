//
//  AuthHeaderView.swift
//  CourseConnect
//
//  Created by Avi Sanchez on 7/26/22.
//

import SwiftUI

struct AuthHeaderView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    let title: String
    
    var body: some View {
        HStack() {
            VStack(alignment: .leading, spacing: 30) {
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title.bold())
                }
                    
                
                
                    Text(title)
                        .font(.largeTitle.bold())
                        .padding(.bottom, 15)
                
                
                    
            }
            .padding(20)
            .padding(.top, 20)
            
            
            
            ZStack {
                Circle()
                    .offset(x: 60, y: -80)
                
                Circle()
                    .offset(x: 110, y: 0)
            }
            .opacity(0.4)
        }
        .frame(height: 160)
        .foregroundColor(Color.theme.white)
    }
}

struct AuthHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        AuthHeaderView(title: "test")
    }
}
