//
//  RootView.swift
//  CourseConnect
//
//  Created by Avi Sanchez on 7/22/22.
//

import SwiftUI

struct RootAuthView: View {
    var body: some View {
        
    
        ZStack {
            
            Color.theme.blue.ignoresSafeArea()

            GeometryReader { g in
                
                VStack {
                    
                    Image("colabpic-removebg-preview")
                        .resizable()
                        .scaledToFit()
                        .frame(width: g.size.width, height: g.size.height * 0.28)
                        .position(x: g.size.width * 0.5, y: g.size.height * 0.25)
                        .padding(.top, g.size.height * 0.02)
                        .shadow(radius: 4)
                        
                    
                        
                    VStack (alignment: .leading) {
                        
                        Spacer()
                        
                        VStack(spacing: 20) {
                            Text("CourseConnect")
                                .font(.largeTitle)
                            .fontWeight(.bold)
                            
                            VStack(alignment: .leading, spacing: g.size.height * 0.015) {
                                Text("Collaborate with your classmates")
                                Text("anytime, anywhere")
                                    .bold()
                            }
                        }
                        
                        
                        Spacer()
                        
                        
                        VStack(spacing: 15) {
                            
                            RoundedRectangle(cornerRadius: 17)
                                .stroke(.white, lineWidth: 3)
                                .overlay(
                                    NavigationLink(destination: RegistrationView()) {
                                        Text("Create an account")
                                            .padding()
                                            .foregroundColor(.white)
                                            .font(.headline.bold())
                                            .frame(width: 329, height: 50)
                                    }
                                )
                                .frame(width: g.size.width * 0.8, height: 50)
                         
                        }
                    }
                    .frame(width: g.size.width * 0.8)
                    .position(x: g.size.width * 0.5, y: g.size.height * 0.18)
                    
                    
                    
                    HStack {
                        
                        Text("Already have an account?")
                            .opacity(0.6)
                        
                    
                        Button {
                            
                        } label: {
                            NavigationLink(destination: LoginView()) {
                                Text("Sign in")
                                    .bold()
                            }
                        }
                       
                        
                        
                    }
                    .font(.subheadline.bold())
                    .padding(.bottom, g.size.height * 0.05)
                    
                }
            }
        }
        .foregroundColor(Color.theme.white)
        .navigationBarHidden(true)
    }
}

struct RootAuthView_Previews: PreviewProvider {
    static var previews: some View {
        RootAuthView()
            .previewInterfaceOrientation(.portrait)
    }
}
