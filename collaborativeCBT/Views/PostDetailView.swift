//
//  PostDetailView.swift
//  collaborativeCBT
//
//  Created by Subeen Park on 2021/12/05.
//

import SwiftUI

struct PostDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode

    struct LayoutConsts {
        static let chipPaddingH: CGFloat = 6
        static let chipPaddingV: CGFloat = 3
    }
    
    @EnvironmentObject var viewModel: PostsViewModel
    @ObservedObject var post: Post
    @State var comment: String = ""
    
    init(post: Post) {
        self.post = post
    }
    
    var body: some View {
        Background { // BACKGROUND
            VStack(alignment: .leading, spacing: 10) { // VSTACK 0
                
                // Scaffolded informations
                VStack(alignment: .leading, spacing: 7) { // VSTACK 1
                    
                    // Emotion
                    HStack { // HSTACK 0
                        Text("감정")
                            .foregroundColor(.subtitlePurple)
                            .bold()
                            .font(.system(size: 13))
                        FlexibleView(data: post.emotions, spacing: 5, alignment: .leading, content: { item in
                            Text(verbatim: item)
                                .foregroundColor(.white)
                                .font(.system(size: 12))
                                .padding([.leading, .trailing], LayoutConsts.chipPaddingH)
                                .padding([.top, .bottom], LayoutConsts.chipPaddingV)
                                .background(Color.mainPurple)
                                .cornerRadius(10)
                        })
                    } // HSTACK 0
                    
                    // CONTEXT
                    HStack { // HSTACK 1
                        Text("상황")
                            .foregroundColor(.subtitlePurple)
                            .bold()
                            .font(.system(size: 13))
                        FlexibleView(data: post.contexts, spacing: 5, alignment: .leading, content: { item in
                            Text(verbatim: item)
                                .foregroundColor(.white)
                                .font(.system(size: 12))
                                .padding([.leading, .trailing], LayoutConsts.chipPaddingH)
                                .padding([.top, .bottom], LayoutConsts.chipPaddingV)
                                .background(Color.mainYellow)
                                .cornerRadius(10)
                        })
                         
                    } // HSTACK 1
                    
                } // VSTACK 1
                .padding([.leading, .trailing], 20)
                
                // Body texts
                Text(post.body)
                    .font(.system(size: 16))
                    .padding([.leading, .trailing], 20)
                    .lineSpacing(4)
                
                // Divider
                HStack {
                    Spacer()
                }
                .frame(height: 4)
                .background(Color.bgGray)

                // Comments
                VStack(alignment: .leading, spacing: 1) { // VSTACK 2
                    ForEach(post.comments, id: \.self) { comment in
                        VStack(alignment: .leading, spacing: 7) { // VSTACK 3
                            Text("17:58")
                                .foregroundColor(.subGray)
                                .font(.system(size: 10))
                            HStack {
                                Text(comment)
                                    .font(.system(size: 14))
                                    .lineSpacing(3)
                                Spacer()
                            }
                        } // VSTACK 3
                        .padding([.leading, .trailing], 20)
                        .padding([.top, .bottom], 10)
                        .background(Color.white)
                    }
                } // VSTACK 2
                .background(Color.bgGray)
                
                Spacer()
                
                // Comment Input
                VStack(alignment: .leading, spacing: 7) { // VSTACK 4
                    
                    FlexibleView(data:Const.commentTrigger, spacing: 6, alignment: .leading) {
                        item in
                            Text(verbatim: item)
                                .foregroundColor(.textGray)
                                .font(.system(size: 14))
                                .padding([.leading, .trailing], LayoutConsts.chipPaddingH)
                                .padding([.top, .bottom], LayoutConsts.chipPaddingV)
                                .cornerRadius(10)
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.textGray, lineWidth: 1))
                                .onTapGesture(perform: {
                                    comment = item
                                })
                    }
                    
                    TextField("댓글을 입력해주세요", text: $comment) {
                        if let postCommented = viewModel.dummiePosts.filter({ $0.body == post.body}).first {
                            postCommented.comments.append(comment)
                        }
                        comment = ""
                        self.endEditing()
                    }
                        .font(.system(size: 12))
                        .padding()
                        .background(Color.bgGray)
                        .cornerRadius(8)
                } // VSTACK 4
                .padding([.leading, .trailing], 10)
                
            } // VSTACK 0
            .padding(.bottom, 10)
        } // BACKGROUND
        .onTapGesture {
            self.endEditing()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        },
                                            label: {
            HStack {
                Image(systemName: "arrow.left.circle")
                    .resizable()
                    .frame(width: 20, height: 20, alignment: .center)
                    .foregroundColor(.mainPurple)
            }
        }))
    } // BODY
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
}
