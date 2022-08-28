//
//  RegistrationView1.swift
//  CourseConnect
//
//  Created by Avi Sanchez on 7/26/22.
//

import SwiftUI


struct RegistrationView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var fullname: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var school: String = "MVHS"
    @State private var grade: String = "Freshman"
    
    @State private var nameError: String? = nil
    @State private var emailError: String? = nil
    @State private var passwordError: String? = nil
    
    private var schoolList = ["MVHS", "LAHS"]
    private var gradeList = ["Freshman", "Sophmore", "Junior", "Senior"]

    
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            
            AuthHeaderView(title: "Sign up")
            
            // Login Body
            ZStack {
              
                backdrop
            
                VStack(alignment: .leading, spacing: 40) {
                    title
                  
                    inputFields
                    
                    submitButton
                    
                    Spacer()
                   
                    footer
                }
                .padding(40)
            }
            .frame(maxHeight: .infinity)
            .ignoresSafeArea()
            
        }
        .background(Color.theme.green)
        .navigationBarHidden(true)
        
    }
}

extension RegistrationView {

    
    var backdrop: some View {
        RoundedRectangle(cornerRadius: 25)
            .foregroundColor(Color.theme.white)
    }
    
    var title: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Welcome")
                .font(.title.bold())
                .foregroundColor(Color.theme.blueDark)
            
            Text("We're glad to see you join!")
                .fontWeight(.medium)
                .opacity(0.4)
                .foregroundColor(Color.theme.black)
            
        }
    }
    
    var inputFields: some View {
        VStack(alignment: .leading, spacing: 35) {
            
            CustomInputField(imageName: "person", placeholderText: "Full name", text: $fullname, secure: false, error: $nameError)
            
            CustomInputField(imageName: "envelope", placeholderText: "School email", text: $email, secure: false, error: $emailError)
            
            CustomInputField(imageName: "lock", placeholderText: "Set password", text: $password, secure: true, error: $passwordError)
            

            HStack {
                Picker("Current school", selection: $school) {
                    ForEach(schoolList, id: \.self) {
                        Text($0)
                    }
                }
                
                Text("|")
                    .foregroundColor(Color.theme.gray)
                    .padding(.bottom, 3)
                
                Picker("Current grade", selection: $grade) {
                    ForEach(gradeList, id: \.self) {
                        Text($0)
                    }
                }
            }
            
            
            
                
        }
        .padding(.top, 20)
    }
    
    var submitButton: some View {
        Button() {
            
            verifyFields()
            
            if nameError == nil && emailError == nil && passwordError == nil {
                viewModel.register(withEmail: email, password: password, fullname: fullname.capitalized, school: school, grade: grade)

            }
            
        } label: {
            RoundedRectangle(cornerRadius: 15)
                .frame(maxWidth: .infinity, maxHeight: 45)
                .foregroundColor(Color.theme.green)
                .shadow(color: Color.theme.green, radius: 2, x: 0, y: 0)
                .overlay(
                    Text("Sign up")
                        .fontWeight(.bold)
                        .foregroundColor(Color.theme.white)
                )
        }
    }
    
    var footer: some View {
        HStack() {
            Spacer()
            Text("Already have an account?")
                
                .fontWeight(.regular)
                .opacity(0.4)
            
            Button {
                
            } label: {
                NavigationLink(destination: LoginView()) {
                    Text("Sign in")
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
        if (fullname.filter{$0 == " "}.count != 1) {
            nameError = "Cannot verify name"
        } else {
            nameError = nil
        }
        
        if !(email.contains("1000") && email.contains("@mvla.net") && email.count == 18) {
            emailError = "Cannot verify school email"
        } else {
            emailError = nil
        }
        
        if (password.count < 6) {
            passwordError = "6 or more characters"
        } else {
            passwordError = nil
        }
    }
    
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
