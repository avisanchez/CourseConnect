//
//  test.swift
//  CourseConnect
//
//  Created by Avi Sanchez on 8/7/22.
//

import SwiftUI

struct test: View {
    
    @State private var comment: String = "Add a comment"
    @State private var isFocused: Bool = false
    
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        
        VStack {
            Spacer()
            
            VStack(alignment: .trailing, spacing: 0) {
                
                if isFocused {
                    HStack {
                        Button {
                            
                            hideKeyboard()
                            isFocused = false
                            
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundColor(Color.theme.black)
                        }
                        
                        
                        Text("Please follow post guidelines")
                            .font(.callout)
                        Spacer()
                    }
                    .padding()
                    
                    Divider()
                }
                
                TextEditor(text: $comment)
                    .frame(maxWidth: .infinity, maxHeight: isFocused ? 100 : 30)
                    .padding(.bottom, 5)
                    .padding(.horizontal, 5)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .padding(.horizontal)
                    .onTapGesture {
                        
                            withAnimation(.spring()) {
                                isFocused = true
                            }
                        
                    }
                
                if isFocused {
                    Divider()
                    Button {
                        
                    } label: {
                        Text("Reply")
                            .fontWeight(.medium)
                            .foregroundColor(comment == "" ? Color.theme.blue.opacity(0.6) : Color.theme.blue)
                            .padding()
                    }
                    .disabled(comment == "")
                    
                }
                
            }
            .background(Color.theme.whiteOff)
        }
        
        
            
    }
}

extension test {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct test_Previews: PreviewProvider {
    static var previews: some View {
        test()
    }
}
