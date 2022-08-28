//
//  CourseConnectApp.swift
//  CourseConnect
//
//  Created by Avi Sanchez on 7/9/22.
//

import SwiftUI
import Firebase

@main
struct CourseConnectApp: App {
    
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
               ContentView()
                    .navigationBarHidden(true)
            }
            .environmentObject(viewModel)
            .preferredColorScheme(.light)
        }
    }
    
}
