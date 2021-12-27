//
//  CustomTabView.swift
//  collaborativeCBT
//
//  Created by Subeen Park on 2021/12/28.
//

import SwiftUI

struct CustomTabView: View {
    
    @StateObject var controlViewModel = PostsViewModel(isControl: true)
    @StateObject var experimentViewModel = PostsViewModel(isControl: false)
    
    init() {
        UITabBar.appearance().barTintColor = UIColor.systemGray2
    }
    
    var body: some View {
        TabView {
            
            NewPostView()
                .environmentObject(controlViewModel)
                .hideKeyboardWhenTappedAround()
                .tabItem({
                    Image(systemName: "1.square.fill")
                })
            
            PostListView()
                .environmentObject(controlViewModel)
                .tabItem({
                    Image(systemName: "2.square.fill")
                })
            
            NewPostView()
                .environmentObject(experimentViewModel)
                .hideKeyboardWhenTappedAround()
                .tabItem({
                    Image(systemName: "3.square.fill")
                })
            
            PostListView()
                .environmentObject(experimentViewModel)
                .tabItem({
                    Image(systemName: "4.square.fill")
                })
            
        }
        .accentColor(.mainPurple)
    }
}

