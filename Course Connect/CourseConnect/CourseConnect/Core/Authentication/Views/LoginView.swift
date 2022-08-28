//
//  LoginView1.swift
//  CourseConnect
//
//  Created by Avi Sanchez on 7/26/22.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @State var email:String = ""
    @State var password:String = ""
    
    
    @State private var emailError: String? = nil
    @State private var passwordError: String? = nil
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            
            AuthHeaderView(title: "Sign in")
            
            // Login Body
            ZStack {
              
                backdrop
            
                VStack(alignment: .leading, spacing: 40) {
                    title
                  
                    inputFields
                    
                    forgotPassword
                    
                    submitButton
                    
                    Spacer()
                   
                    footer
                }
                .padding(40)
            }
            .frame(maxHeight: .infinity)
            .ignoresSafeArea()
        
        }
        .background(Color.theme.blue)
        .navigationBarHidden(true)
        
    }
        
}

extension LoginView {
    var backdrop: some View {
        RoundedRectangle(cornerRadius: 25)
            .foregroundColor(Color.theme.white)
    }
    
    var title: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Welcome Back")
                .font(.title.bold())
                .foregroundColor(Color.theme.blueDark)
            
            Text("Hello there, sign in to continue!")
                .fontWeight(.medium)
                .opacity(0.4)
                .foregroundColor(Color.theme.black)
            
        }
    }
    
    var inputFields: some View {
        VStack(alignment: .leading, spacing: 35) {
            
            CustomInputField(imageName: "envelope", placeholderText: "Enter your email", text: $email, secure: false, error: $emailError)
            
            CustomInputField(imageName: "lock", placeholderText: "Enter your password", text: $password, secure: true, error: $passwordError)
    
        }
        .padding(.top, 25)
    }
    
    var submitButton: some View {
        Button() {
            
            viewModel.login(withEmail: email, password: password)
            
            if viewModel.currentUser == nil {
                print("DEBUG: viewModel.currentUser == nil")
                verifyFields()
            }
        } label: {
            RoundedRectangle(cornerRadius: 15)
                .frame(maxWidth: .infinity, maxHeight: 45)
                .foregroundColor(Color.theme.blue)
                .shadow(color: Color.theme.blue, radius: 2, x: 0, y: 0)
                .overlay(
                    Text("Sign in")
                        .fontWeight(.bold)
                        .foregroundColor(Color.theme.white)
                )
        }
        
        
    }
    
    var forgotPassword: some View {
        Button {
            
        } label: {
            NavigationLink(destination: ResetPasswordView()) {
                Text("Forgot Password?")
                    .bold()
                    .foregroundColor(Color.theme.blue)
            }
        }
    }
    
    var footer: some View {
        HStack() {
            
            Spacer()
            
            Text("Don't have an account?")
                .fontWeight(.regular)
                .opacity(0.4)
            
            Button {
                
            }
            label: {
                NavigationLink(destination: RegistrationView()) {
                    Text("Sign up")
                        .foregroundColor(Color.theme.blue)
                }
            }
            
            
            Spacer()
        }
        .padding(.bottom, 20)
        .foregroundColor(.black)
        .font(.callout.bold())
    }
    
    func verifyFields() {

        if !(email.contains("1000") && email.contains("@mvla.net") && email.count == 18) {
            emailError = "Cannot verify school email"
        } else {
            emailError = nil
        }
        
        if (password.count < 6) {
            passwordError = "Incorrect Password"
        } else {
            passwordError = nil
        }
    }
    
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
