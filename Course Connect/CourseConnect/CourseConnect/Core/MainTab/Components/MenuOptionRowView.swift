//
//  SideMenuOptionRowView.swift
//  CourseConnect
//
//  Created by Avi Sanchez on 7/28/22.
//

import SwiftUI

struct MenuOptionRowView: View {
    
    let imageName: String
    let title: String
    
    var body: some View {
        HStack() {
            Image(systemName: imageName)
            Text(title)
                .fontWeight(.medium)
            Spacer()
        }
    }
}
