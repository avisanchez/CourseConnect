//
//  ContentView.swift
//  CourseConnect
//
//  Created by Avi Sanchez on 7/27/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showMenu = false // implement later
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Group {
            if viewModel.userSession == nil {
                RootAuthView()
            } else {
                mainInterfaceView
            }
        }
        .navigationBarHidden(true)

    }
}

extension ContentView {
    var mainInterfaceView: some View {
        MainTabView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


