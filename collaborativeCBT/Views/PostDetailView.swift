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
    @State var commentTrigger: [String] = []
    @State var showCommentAdvice = false
    
    init(post: Post) {
        self.post = post
    }
    
    var body: some View {
        Background { // BACKGROUND
            VStack(alignment: .leading, spacing: 10) { // VSTACK 0
                
                // Scaffolded informations
                if !viewModel.isControl {
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
                }
               
                
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
                    
                    if !viewModel.isControl {
                        
                        HStack(alignment: .bottom) {
                            Image(systemName: showCommentAdvice ? "info.circle.fill" : "info.circle")
                                .foregroundColor(.subGray)
                                .onTapGesture {
                                    showCommentAdvice.toggle()
                                }
                                .padding([.bottom], 7)
                                .padding([.leading], 3)
                            
                            
                            if showCommentAdvice {
                                Text("여기에 무슨 말을 넣는게 좋을까요?!")
                                    .foregroundColor(Color(uiColor: UIColor.systemGray))
                                    .font(.system(size: 13))
                                    .padding(7)
                                    .background(Color.bgGray)
                                    .cornerRadius(8)
                            }
                           
                        }
                        
                        
                        
                        
                        if comment.count != 0 {
                            Text(verbatim: "본인의 비슷한 경험 + 관련한 질문 순으로 댓글을 이어나가 보세요!")
                                .foregroundColor(.red)
                                .font(.system(size: 13).bold())
                                .padding([.leading, .trailing], LayoutConsts.chipPaddingH)
                                .padding([.top, .bottom], LayoutConsts.chipPaddingV)
                        }
                        else {
                            FlexibleView(data:commentTrigger, spacing: 6, alignment: .leading) {
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
                        }
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
        .onAppear {
            
//            post.emotions.contains(where: <#T##(String) throws -> Bool#>)
            if !post.emotions.isEmpty {
                commentTrigger = getCommentRecommendations(emotion: post.emotions[0])
            }
            
        }
    } // BODY
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
    
    func getCommentRecommendations(emotion: String) -> [String] {
        switch emotion {
        case "기쁨":
            return Const.commentTrigger[emotion]!
        default:
            var comments: [String] = []
            
            guard let emotionDefault = Const.commentTrigger["기본"] else {
                return []
            }
            
            if var emotionSpecific = Const.commentTrigger[emotion] {
                emotionSpecific.shuffle()
                comments.append(contentsOf: Array(emotionSpecific[0..<2]))
                comments.append(emotionDefault[0])
                
            } else {
                comments.append(contentsOf: emotionDefault)
            }
            
            return comments
        }
    }
}
