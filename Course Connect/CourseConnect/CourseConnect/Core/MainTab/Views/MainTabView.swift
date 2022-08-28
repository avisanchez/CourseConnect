//
//  MainTabView2.swift
//  CourseConnect
//
//  Created by Avi Sanchez on 7/31/22.
//

import SwiftUI

struct MainTabView: View {
    
    @State private var selectionIndex: Int = 0
    @State private var showNewPostView: Bool = false
    
    var body: some View {
        
        ZStack {
            
            if selectionIndex == 0 {
                HomeView()
            }
            
            if selectionIndex == 2 {
                ExploreView()
            }
            
            VStack {
                Spacer()
                
                HStack {
                    
                    Button {
                        self.selectionIndex = 0
                    } label: {
                        Image(systemName: "house")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 25)
                            .foregroundColor(selectionIndex == 0 ? Color.theme.blue : Color.theme.gray)
                    }
                    .padding(.horizontal, 40)
                    
                    Spacer()
                    
                    Button {
                        self.selectionIndex = 1
                        self.showNewPostView = true
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 23)
                            .foregroundColor(selectionIndex == 1 ? Color.theme.blue : Color.theme.gray)
                    }
                    
                    Spacer()
                    
                    Button {
                        self.selectionIndex = 2
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 25)
                            .foregroundColor(selectionIndex == 2 ? Color.theme.blue : Color.theme.gray)
                    }
                    .padding(.horizontal, 40)
                }
                .padding()
                .background(Color.theme.whiteOff)
                
            }
        
        }
        .fullScreenCover(isPresented: $showNewPostView) {
            withAnimation(.spring()) {
                NewPostViewFlow()
            }
        }
        .onChange(of: showNewPostView) { newValue in
            if newValue == false {
                selectionIndex = 0
            }
        }
        
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
