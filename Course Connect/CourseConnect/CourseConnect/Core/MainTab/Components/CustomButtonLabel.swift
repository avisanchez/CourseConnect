//
//  CustomButtonLabel.swift
//  CourseConnect
//
//  Created by Avi Sanchez on 7/26/22.
//

import SwiftUI

struct CustomButtonLabel: View {
    
    let labelTitle: String
    @Binding var currentTopic: String
    
    var body: some View {
        Text(labelTitle)
            .fontWeight(.semibold)
            .padding(13)
            .background(Color.theme.gray.opacity(0.3))
            .cornerRadius(10)
            .foregroundColor(currentTopic == labelTitle ? Color.theme.blue : Color.theme.black)
    }
}

struct CustomButtonLabel_Previews: PreviewProvider {
    static var previews: some View {
        CustomButtonLabel(labelTitle: "Filler", currentTopic: .constant("Test"))
    }
}
