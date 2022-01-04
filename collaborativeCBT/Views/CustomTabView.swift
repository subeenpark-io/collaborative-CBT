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
    @State private var tabSelection = 1
    
    init() {
        UITabBar.appearance().barTintColor = UIColor.systemGray2
    }
    
    var body: some View {
        TabView(selection: $tabSelection) {
            
            NewPostView(tabSelection: $tabSelection)
                .environmentObject(controlViewModel)
                .hideKeyboardWhenTappedAround()
                .tabItem({
                    Image(systemName: "1.square.fill")
                })
                .tag(1)
            
            PostListView(tabSelection: $tabSelection)
                .environmentObject(controlViewModel)
                .tabItem({
                    Image(systemName: "2.square.fill")
                })
                .tag(2)
            
            NewPostView(tabSelection: $tabSelection)
                .environmentObject(experimentViewModel)
                .hideKeyboardWhenTappedAround()
                .tabItem({
                    Image(systemName: "3.square.fill")
                })
                .tag(3)
            
            PostListView(tabSelection: $tabSelection)
                .environmentObject(experimentViewModel)
                .tabItem({
                    Image(systemName: "4.square.fill")
                })
                .tag(4)
            
        }
        .accentColor(.mainPurple)
    }
}

