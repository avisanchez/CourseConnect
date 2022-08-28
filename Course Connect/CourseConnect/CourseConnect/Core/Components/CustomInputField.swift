//
//  CustomInputField.swift
//  CourseConnect
//
//  Created by Avi Sanchez on 7/26/22.
//

import SwiftUI

struct CustomInputField: View {
    
    let imageName: String
    let placeholderText: String
    @Binding var text: String
    let secure: Bool
    @Binding var error: String?
    
    @State private var showPassword: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(error != nil ? Color.theme.red : Color.theme.gray)
                
                
                
                ZStack {
                    HStack() {
                        if text.isEmpty {
                            Text(error != nil ? error! : placeholderText)
                                .foregroundColor(error != nil ? Color.theme.red : Color.theme.gray)
                            Spacer()
                        }
                    }
                    
                    if secure {
                        
                        if showPassword {
                            textField
                        }
                        else {
                            secureField
                        }
                        
                        HStack {
                            Spacer()
                            
                            Button {
                                showPassword.toggle()
                            }
                            label: {
                                Image(systemName: showPassword ? "eye" : "eye.slash")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(Color.theme.gray)
                            }
                        }
                        
                    } else {
                        textField
                    }
                }
            }
            
            Divider()
                .background(.gray)
        }

    }
    
}

extension CustomInputField {
    var secureField: some View {
        SecureField("", text: $text)
            .disableAutocorrection(true)
            .textInputAutocapitalization(.never)
            .foregroundColor(Color.theme.black)
            
    }
    
    var textField: some View {
        TextField("", text: $text)
            .disableAutocorrection(true)
            .textInputAutocapitalization(.never)
            .foregroundColor(Color.theme.black)
            
    }
}

//struct CustomInputField_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomInputField(imageName: "pencil", placeholderText: "fix later", text: T##Binding<String>)
//    }
//}
