//
//  NewPostView.swift
//  collaborativeCBT
//
//  Created by Subeen Park on 2021/12/05.
//

import SwiftUI
import Combine

struct NewPostView: View {
    
    @EnvironmentObject var viewModel : PostsViewModel
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var textObserver = TextFieldObserver()
    @FocusState private var textfieldFocused: Bool
    
    @State var bodyText: String = "저녁 약속 때문에 친구랑 살짝 다퉜는데 나중에 생각해보니 내가 하지 말아야 할 말을 해서 친구 기분이 상한 것 같아서 슬퍼졌음."
    var placeholder = "저녁 약속 때문에 친구랑 살짝 다퉜는데 나중에 생각해보니 내가 하지 말아야 할 말을 해서 친구 기분이 상한 것 같아서 슬퍼졌음."
    
    @State var isWritingComplete = false
    
    struct LayoutConsts {
        static let chipPaddingH: CGFloat = 6
        static let chipPaddingV: CGFloat = 3
    }
    
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) { // VSTACK 0
            
            // raw text
            VStack(alignment: .leading, spacing: 7) { // VSTACK 1
                Text("상황을 자유롭게 적어주세요")
                    .foregroundColor(.titlePurple)
                    .font(.system(size: 24, weight: .heavy, design: .default))
                VStack {
                    TextEditor(text: $textObserver.searchText)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 120, maxHeight: 150)
                        .foregroundColor(textObserver.searchText == placeholder ? .textGray : .black)
                        .onTapGesture {
                            if self.textObserver.searchText == placeholder {
                                self.textObserver.searchText = ""
                            }
                        }
                        .focused($textfieldFocused)
                        .font(.system(size: 14))
                        .lineSpacing(4)
                        .colorMultiply(Color.bgGray)
                }
                .onReceive(textObserver.$debouncedText) { (val) in
                    bodyText = val
                    print("RECEIVED \(val)")
                }
                .padding(8)
                .background(Color.bgGray)
                .cornerRadius(8)
    
                
            } // VSTACK 1
            
            if !viewModel.isControl {
                
                if !viewModel.isComplete {
                    
                    HStack {
                        Spacer()
                        Text("다 적었어요")
                            .bold()
                            .foregroundColor(.white)
                            .font(.system(size: 12))
                            .padding(6)
                            .background(bodyText.count > 10 ? Color.mainPurple : Color.subGray)
                            .cornerRadius(16)
                            .onTapGesture {
                                if bodyText.count > 10 {
                                    viewModel.clearInputs()
                                    isWritingComplete = true
                                    viewModel.newPost(text: bodyText)
                                }
                                textfieldFocused = false
                            }
                    }
                    
                }
                
                
                
                if !viewModel.isComplete && isWritingComplete {
                    VStack(spacing: 10) {
                        HStack {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                        Text("잠시만 기다려주세요")
                            .foregroundColor(.subGray)
                            .font(.system(size: 14))
                    }
                }
                
                if viewModel.isComplete {
                    // emotions
                    VStack(alignment: .leading, spacing: 7) { // VSTACK 2
                        HStack {
                            Image("emoji")
                            Text("지금 감정이 어떤가요?")
                                .foregroundColor(.subtitlePurple)
                                .font(.system(size: 16))
                                .bold()
                            Spacer()
                        }
                        
                        
                        VStack(spacing: 7) {
                            FlexibleView(data: viewModel.emotions, spacing: 6, alignment: .leading) { item in
                                Text(verbatim: item)
                                    .foregroundColor(.textGray)
                                    .font(.system(size: 12))
                                    .padding([.leading, .trailing], LayoutConsts.chipPaddingH)
                                    .padding([.top, .bottom], LayoutConsts.chipPaddingV)
                                    .cornerRadius(10)
                                    .overlay(RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.textGray, lineWidth: 1))
                                    .onTapGesture {
                                        viewModel.selectedEmotions.append(item)
                                        viewModel.emotions = viewModel.emotions.filter({$0 != item})
                                    }
                            }
                            VStack(spacing: 10) {
                                if !viewModel.selectedEmotions.isEmpty {
                                    FlexibleView(data: viewModel.selectedEmotions, spacing: 6, alignment: .leading) { item in
                                        HStack(spacing: 3) {
                                            Text(verbatim: item)
                                            
                                            Image(systemName: "xmark")
                                                .foregroundColor(.mainPurple)
                                                .font(.system(size: 12))
                                                .onTapGesture {
                                                    if viewModel.dummiePosts.map({$0.emotions}).reduce([], +).contains(item) {
                                                        viewModel.emotions.append(item)
                                                    }
                                                    viewModel.selectedEmotions = viewModel.selectedEmotions.filter({$0 != item})
                                                }
                                        }
                                        .foregroundColor(.mainPurple)
                                        .font(.system(size: 12))
                                        .padding([.leading, .trailing], LayoutConsts.chipPaddingH)
                                        .padding([.top, .bottom], LayoutConsts.chipPaddingV)
                                        .cornerRadius(10)
                                        .overlay(RoundedRectangle(cornerRadius: 10)
                                                    .stroke(Color.mainPurple, lineWidth: 1))
                                        
                                    }
                                }
                                
                                HStack(spacing: 5) {
                                    Image(systemName: "plus.circle.fill")
                                        .font(.system(size: 14))
                                        .foregroundColor(.textGray)
                                    TextField("위의 추천 태그를 탭하거나 직접 입력해 추가해주세요", text: $viewModel.emotionField) {
                                        if !viewModel.selectedEmotions.contains(viewModel.emotionField) {
                                            viewModel.selectedEmotions.append(viewModel.emotionField)
                                        }
                                        viewModel.emotionField = ""
                                    }
                                    .font(.system(size: 12))
                                    Spacer()
                                }
                            }
                            .padding(10)
                            .background(Color.white)
                            .cornerRadius(6)
                        }
                        .padding(8)
                        .background(Color.bgGray)
                        .cornerRadius(8)
                        
                        
                        
                    } // VSTACK 2
                    
                    // contexts
                    VStack(alignment: .leading, spacing: 7) { // VSTACK 3
                        
                        HStack {
                            Image("check")
                            Text("감정의 원인이 무엇이었나요?")
                                .foregroundColor(.subtitlePurple)
                                .font(.system(size: 16))
                                .bold()
                            Spacer()
                        }
                        
                        
                        VStack(spacing: 7) {
                            FlexibleView(data: viewModel.contexts, spacing: 6, alignment: .leading) { item in
                                Text(verbatim: item)
                                    .foregroundColor(.textGray)
                                    .font(.system(size: 12))
                                    .padding([.leading, .trailing], LayoutConsts.chipPaddingH)
                                    .padding([.top, .bottom], LayoutConsts.chipPaddingV)
                                    .cornerRadius(10)
                                    .overlay(RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.textGray, lineWidth: 1))
                                    .onTapGesture {
                                        viewModel.selectedContexts.append(item)
                                        viewModel.contexts = viewModel.contexts.filter({$0 != item})
                                    }
                            }
                            VStack(spacing: 10) {
                                if !viewModel.selectedContexts.isEmpty {
                                    FlexibleView(data: viewModel.selectedContexts, spacing: 6, alignment: .leading) { item in
                                        HStack(spacing: 3) {
                                            Text(verbatim: item)
                                            
                                            Image(systemName: "xmark")
                                                .foregroundColor(.mainYellow)
                                                .font(.system(size: 12))
                                                .onTapGesture {
                                                    if viewModel.dummiePosts.map({$0.contexts}).reduce([], +).contains(item) {
                                                        viewModel.contexts.append(item)
                                                    }
                                                    viewModel.selectedContexts = viewModel.selectedContexts.filter({$0 != item})
                                                }
                                        }
                                        .foregroundColor(.mainYellow)
                                        .font(.system(size: 12))
                                        .padding([.leading, .trailing], LayoutConsts.chipPaddingH)
                                        .padding([.top, .bottom], LayoutConsts.chipPaddingV)
                                        .cornerRadius(10)
                                        .overlay(RoundedRectangle(cornerRadius: 10)
                                                    .stroke(Color.mainYellow, lineWidth: 1))
                                        
                                    }
                                }
                                
                                HStack(spacing: 5) {
                                    Image(systemName: "plus.circle.fill")
                                        .font(.system(size: 14))
                                        .foregroundColor(.textGray)
                                    TextField("위의 추천 태그를 탭하거나 직접 입력해 추가해주세요", text: $viewModel.contextField) {
                                        if !viewModel.selectedContexts.contains(viewModel.contextField) {
                                            viewModel.selectedContexts.append(viewModel.contextField)
                                        }
                                        viewModel.contextField = ""
                                    }
                                    .font(.system(size: 12))
                                    Spacer()
                                }
                            }
                            .padding(10)
                            .background(Color.white)
                            .cornerRadius(6)
                        }
                        .padding(8)
                        .background(Color.bgGray)
                        .cornerRadius(8)
                        
                        HStack {
                            Spacer()
                            Text("기록 끝내기")
                                .bold()
                                .foregroundColor(.white)
                                .font(.system(size: 12))
                                .padding(6)
                                .background(Color.mainPurple)
                                .cornerRadius(20)
                                .onTapGesture {
                                    viewModel.dummiePosts.append(Post(emotions: viewModel.selectedEmotions, contexts: viewModel.selectedContexts, body: bodyText, comments: []))
        //                            self.presentationMode.wrappedValue.dismiss()
                                    textObserver.searchText = ""
                                    textObserver.debouncedText = ""
                                    isWritingComplete = false
                                    viewModel.clearInputs()
                                }
                            
                        }
                        
                        
                        
                        
                    } // VSTACK 3
                    
                    
                }
                
            } else {
                HStack {
                    Spacer()
                    Text("기록 끝내기")
                        .bold()
                        .foregroundColor(.white)
                        .font(.system(size: 12))
                        .padding(6)
                        .background(Color.mainPurple)
                        .cornerRadius(20)
                        .onTapGesture {
                            textfieldFocused = false
                            viewModel.dummiePosts.append(Post(emotions: viewModel.selectedEmotions, contexts: viewModel.selectedContexts, body: bodyText, comments: []))
//                            self.presentationMode.wrappedValue.dismiss()
                            textObserver.searchText = ""
                            viewModel.clearInputs()
                            
                        }
                    
                }
            }
            
        
            
            Spacer()
        } // VSTACK 0
        .padding([.top], 44)
        .padding([.leading, .trailing], 15)
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
            viewModel.clearInputs()
            textObserver.searchText = self.placeholder
        }
        
    }
    
}


class TextFieldObserver : ObservableObject {
    @Published var debouncedText = ""
    @Published var searchText = ""
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        $searchText
            .debounce(for: .seconds(0.1), scheduler: DispatchQueue.main)
            .sink(receiveValue: { t in
                self.debouncedText = t
            } )
            .store(in: &subscriptions)
    }
}
