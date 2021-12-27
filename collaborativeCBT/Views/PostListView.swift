//
//  PostListView.swift
//  collaborativeCBT
//
//  Created by Subeen Park on 2021/12/05.
//

import SwiftUI

struct PostListView: View {
    
    @EnvironmentObject var viewModel: PostsViewModel
    
    var posts: [Post] {
        if emotionSelected.isEmpty && contextSelected.isEmpty {
            return viewModel.dummiePosts
        }
        else if contextSelected.isEmpty {
            return viewModel.dummiePosts.filter({
                !Set($0.emotions).intersection(Set(emotionSelected)).isEmpty
            })
        }
        else if emotionSelected.isEmpty {
            return viewModel.dummiePosts.filter({
                !Set($0.contexts).intersection(Set(contextSelected)).isEmpty
            })
        }
        else {
            return viewModel.dummiePosts.filter({
                !Set($0.contexts).intersection(Set(contextSelected)).isEmpty &&
                !Set($0.emotions).intersection(Set(emotionSelected)).isEmpty
            })
        }
        
    }
    
    @State var emotionSelected: [String] = []
    @State var contextSelected: [String] = []
    
    struct LayoutConsts {
        static let chipPaddingH: CGFloat = 6
        static let chipPaddingV: CGFloat = 3
    }
    
    var body: some View {
        
        NavigationView { // NAVIGATION VIEW
            VStack(spacing: 3) { // VSTACK 0
                
                // Filters
                if !viewModel.isControl {
                    VStack { // VSTACK 1
                        // Emotions
                        VStack(alignment: .leading, spacing: 7) { // VSTACK 2
                            
                            Text("감정")
                                .foregroundColor(.subtitlePurple)
                                .bold()
                                .font(.system(size: 13))
                            
                           
                            
                            FlexibleView(data: viewModel.dummiePosts.map({$0.emotions}).reduce([], +), spacing: 6, alignment: .leading) { item in
                                
                                Text(verbatim: item)
                                    .foregroundColor(emotionSelected.contains(item) ? Color.white : Color.mainPurple)
                                    .font(.system(size: 12))
                                    .padding([.leading, .trailing], LayoutConsts.chipPaddingH)
                                    .padding([.top, .bottom], LayoutConsts.chipPaddingV)
                                    .cornerRadius(10)
                                    .background(RoundedRectangle(cornerRadius: 10)
                                                    .stroke(Color.mainPurple, lineWidth: 1)
                                                    .background(RoundedRectangle(cornerRadius: 10).fill(emotionSelected.contains(item) ? Color.mainPurple : Color.clear))
                                                )
                                    .onTapGesture {
                                        if emotionSelected.contains(item) {
                                            emotionSelected = emotionSelected.filter({$0 != item})
                                        }
                                        else {
                                            emotionSelected.append(item)
                                        }
                                    }

                            }
                        } // VSTACK 2
                        
                        // Contexts
                        // Emotions
                        VStack(alignment: .leading, spacing: 7) { // VSTACK 3
                            
                            Text("상황")
                                .foregroundColor(.subtitlePurple)
                                .bold()
                                .font(.system(size: 13))
                            
                            FlexibleView(data: viewModel.dummiePosts.map({$0.contexts}).reduce([], +), spacing: 6, alignment: .leading) { item in
                                
                                Text(verbatim: item)
                                    .foregroundColor(contextSelected.contains(item) ? Color.white : Color.mainYellow)
                                    .font(.system(size: 12))
                                    .padding([.leading, .trailing], LayoutConsts.chipPaddingH)
                                    .padding([.top, .bottom], LayoutConsts.chipPaddingV)
                                    .cornerRadius(10)
                                    .background(RoundedRectangle(cornerRadius: 10)
                                                    .stroke(Color.mainYellow, lineWidth: 1)
                                                    .background(RoundedRectangle(cornerRadius: 10).fill(contextSelected.contains(item) ? Color.mainYellow : Color.clear))
                                                )
                                    .onTapGesture {
                                        if contextSelected.contains(item) {
                                            contextSelected = contextSelected.filter({$0 != item})
                                        }
                                        else {
                                            contextSelected.append(item)
                                        }
                                    }

                            }
                        } // VSTACK 3
                    } // VSTACK 1
                    .padding([.top, .bottom], 10)
                    .padding([.leading, .trailing], 20)
                    .background(Color.bgGray)
                }
                
                // Posts
                
                VStack { // VSTACK 3

                    ScrollView { // SCROLL VIEW 0
                        ForEach(posts) { post in // LIST 0
                            NavigationLink(destination: PostDetailView(post: post).environmentObject(viewModel)) { // NAVIGATION LINK 1
                                VStack(alignment: .leading, spacing: 7) { // VSTACK 4
                                    
                                    if !viewModel.isControl {
                                        FlexibleView(data: post.contexts+post.emotions, spacing: 6, alignment: .leading) { item in
                                            Text(verbatim: item)
                                                .foregroundColor(.white)
                                                .font(.system(size: 12))
                                                .padding([.leading, .trailing], LayoutConsts.chipPaddingH)
                                                .padding([.top, .bottom], LayoutConsts.chipPaddingV)
                                                .background(post.emotions.contains(item) ? Color.mainPurple : Color.mainYellow)
                                                .cornerRadius(10)
                                        } // FLEXIBLE VIEW
                                    }
                         
                                    Text(post.body)
                                        .font(.system(size: 14))
                                        .lineSpacing(4)
                                        .lineLimit(2)
                                        .foregroundColor(.black)
                                        .multilineTextAlignment(.leading)
                                } // VSTACK 4
                                .padding(8)
                                .background(Color.white)
                                .cornerRadius(6)
                            }  // NAVIGATION LINK 1
                        } // LIST 0
                    } // SCROLL VIEW 0
                    Spacer()
                    
                    
                } // VSTACK 3
                .padding([.top, .bottom], 10)
                .padding([.leading, .trailing], 10)
                .background(Color.bgGray)
                
            } // VSTACK 0
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarColor(UIColor(Color.bgGray))
            
            
        }
        
       
    }
}
