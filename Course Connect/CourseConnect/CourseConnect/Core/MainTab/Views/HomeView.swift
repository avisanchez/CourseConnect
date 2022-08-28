//
//  HomePageView.swift
//  CourseConnect
//
//  Created by Avi Sanchez on 7/26/22.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State private var searchBarVisible: Bool = false
    @State private var textFieldText: String = ""
    @State private var menuVisible: Bool = false
    @State var currentTopic: String = "Popular"
     
    let testCardColors: [Color] = [Color.theme.purple, Color.theme.green2, Color.theme.blue3, Color.theme.red2, Color.theme.teal]
    
 
                                                                                                              
    
    var body: some View {

        VStack {
            
            headerView
                
            ZStack(alignment: .bottomTrailing) {
                
                backdrop
                
                    
                ScrollView(.vertical) {
                    
                    topicFilterButtons
                        
                    topicCardstylePreview
                    
                    trendingPostsPreview
                    
                }
                .padding()
                    
            }
            .onTapGesture {
                if menuVisible {
                    withAnimation(.spring()) {
                        menuVisible = false
                    }
                }
            }
        }
        .background(Color.theme.blue)
        .navigationBarHidden(true)
    }
}

extension HomeView {
    
    var headerView: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    if let user = viewModel.currentUser {
                        let firstname: String = String(user.fullname.split(separator: " ")[0])
                        
                        Text("Hi, \(firstname)")
                            .font(.title.bold())
                    } else {
                        Text("Hi, user")
                            .font(.title.bold())
                    }
                    
                    Text("Find classes you'd like to explore")
                        .font(.callout)
                        .opacity(0.5)
                }
                .padding()
                
                Spacer()
                
                Button {
                    withAnimation(.spring()) {
                        menuVisible.toggle()
                    }
                } label: {
                    Circle()
                        .foregroundColor(.blue)
                        .frame(width: 45, height: 45)
                        .overlay(alignment: .center, content: {
                            VStack {
                                
                                if viewModel.currentUser?.school == "MVHS" {
                                    Image("mvhslogo")
                                        .renderingMode(.template)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 23)
                                } else {
                                    Image("lahslogo")
                                        .renderingMode(.template)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25)
                                }
                                
                            }
                            .frame(width: 50, height: 50)
                        })
                        .padding(.trailing)
                        .padding(.bottom)
                }
            }
            
            if menuVisible {
                menu
            }
            
            Spacer()
        }
        .frame(height: menuVisible ? 300 : 100)
        .padding(.top, 10)
        .foregroundColor(Color.theme.white)
    }
    
    var menu: some View {
        VStack {
            ForEach(MenuViewModel.allCases, id: \.rawValue) { option in
                if option == .profile {
                    if let user = viewModel.currentUser {
                        NavigationLink(destination: ProfileView(user: user)) {
                            MenuOptionRowView(imageName: option.imageName, title: option.title)
                        }
                        .onTapGesture {
                            menuVisible = false
                        }
                    }
                } else if option == .learnMore {
                    NavigationLink(destination: LearnMoreView()) {
                        MenuOptionRowView(imageName: option.imageName, title: option.title)
                    }
                } else if option == .logout {
                    Button {
                        viewModel.signOut()
                    } label: {
                        MenuOptionRowView(imageName: option.imageName, title: option.title)
                    }
                }
                
            }
            .padding(.vertical)
            .padding(.horizontal, 30)
            .frame(maxWidth: .infinity)

        }
        
    }
        
    
    // ---------------------------------------------------------------
    
    var backdrop: some View {
        RoundedRectangle(cornerRadius: 30)
            .foregroundColor(Color.theme.whiteOff)
            .ignoresSafeArea()
    }
    
    var topicFilterButtons: some View {
        ScrollView(.horizontal, showsIndicators: false)  {
            HStack(spacing: 20) {

                Button {
                    let temp = currentTopic
                    currentTopic = ""
                    currentTopic = temp
                } label: {
                    Image(systemName: "arrow.triangle.2.circlepath")
                        .renderingMode(.template)
                        .foregroundColor(Color.theme.black)
                }
                
                // topic buttons
                ForEach(TopicFilterViewModel.allCases, id: \.rawValue) { option in
                    Button {
                        currentTopic = option.title
                        withAnimation(.spring()) {
                            searchBarVisible = false
                        }
                    } label: {
                        CustomButtonLabel(labelTitle: option.title, currentTopic: $currentTopic)
                    }
                }
            }
        }
        .padding(.top, 20)
    }
    
    // ---------------------------------------------------------------
    
    var topicCardstylePreview: some View {
        
        VStack(alignment: .leading) {
            Text("\(currentTopic) Topics")
                .font(.title.bold())
                .padding(.top)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 20) {
                    
                    ForEach(0..<5, id: \.self) { indx in
                        NavigationLink(destination: Text("Hello World")) {
                            CustomTopicCard(courseName: "APUSH", totalPosts: 20, color: Color.theme.red)
                        }
                        
                    }
                    
                }
            }
        }
        .foregroundColor(Color.theme.blueDark)
    }
    
    // ---------------------------------------------------------------
    
    var trendingPostsPreview: some View {
        LazyVStack(alignment: .leading) {
            Text("Trending Posts")
                .font(.title.bold())
                .padding(.top)
            
            PostFeedView()

        }
        .foregroundColor(Color.theme.blueDark)
        .transaction { transaction in
            transaction.animation = nil
        }
    }
    
    func fetchTopicList(topic: String) -> [String] {
        
        var list: [String] = ["", "", "", "", ""]
        
        return list
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
