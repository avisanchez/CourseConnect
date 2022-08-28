//
//  ResetPasswordView1.swift
//  CourseConnect
//
//  Created by Avi Sanchez on 7/26/22.
//

import SwiftUI

struct ResetPasswordView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var email: String = ""
    @State private var showConfirmation: Bool = false
    @State private var emailError: String? = nil
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            
            AuthHeaderView(title: "Reset")
            
            // Reset Body
            ZStack {
                backdrop
            
                VStack(alignment: .leading, spacing: 40) {
                    title
                  
                    inputFields
                    
                    if showConfirmation {
                        confirmationMessage
                    }
                    
                    submitButton
                    
                    Spacer()
                   
                    footer
                }
                .padding(40)
            }
            .frame(maxHeight: .infinity)
            .ignoresSafeArea()
            
        }
        .background(Color.theme.red)
        .navigationBarHidden(true)
        
    }
}

extension ResetPasswordView {

    
    var backdrop: some View {
        RoundedRectangle(cornerRadius: 25)
            .foregroundColor(Color.theme.white)
    }
    
    var title: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("No Worries")
                .font(.title.bold())
                .foregroundColor(Color.theme.blueDark)
            
            Text("Complete fields and check email to continue")
                .fontWeight(.medium)
                .opacity(0.4)
                .foregroundColor(Color.theme.black)
            
        }
    }
    
    var inputFields: some View {
        VStack(alignment: .leading, spacing: 35) {
            
            CustomInputField(imageName: "envelope", placeholderText: "Enter your email", text: $email, secure: false, error: $emailError)
    
        }
        .padding(.top, 25)
    }
    
    var confirmationMessage: some View {
        HStack {
            Text("A reset link has been sent to your inbox")
                .foregroundColor(Color.theme.blueDark.opacity(0.8))
                .font(.callout)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
        }
        
    }
    
    var submitButton: some View {
        Button() {
            
            verifyFields()
            
            if emailError == nil {
                viewModel.resetPassword(withEmail: email)
                showConfirmation = true
            }
            
        } label: {
            RoundedRectangle(cornerRadius: 15)
                .frame(maxWidth: .infinity, maxHeight: 45)
                .foregroundColor(showConfirmation ? Color.theme.red.opacity(0.3) : Color.theme.red)
                .shadow(color: Color.theme.red, radius: 2, x: 0, y: 0)
                .overlay(
                    Text("Reset Password")
                        .fontWeight(.bold)
                        .foregroundColor(Color.theme.white)
                )
        }
        .disabled(showConfirmation ? true : false)
    }
    
    var footer: some View {
        HStack() {
            Spacer()
            Text("Not seeing an email? Try checking \njunk or spam folder.")
                .fontWeight(.regular)
                .opacity(0.4)
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .font(.callout.bold())
            Spacer()
        }
        .padding(.bottom, 20)
        
    }
    
    func verifyFields() {
        
        if !(email.contains("1000") && email.contains("@mvla.net") && email.count == 18) {
            emailError = "Cannot verify school email"
        } else {
            emailError = nil
        }
        
    }
    
}


struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
