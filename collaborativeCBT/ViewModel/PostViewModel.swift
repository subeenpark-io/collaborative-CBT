//
//  PostViewModel.swift
//  collaborativeCBT
//
//  Created by Subeen Park on 2021/12/05.
//


import SwiftUI
import Moya
import RxSwift

class PostsViewModel: ObservableObject {

    @Published var isControl: Bool = false
    @Published var dummiePosts = Const.dummyPosts
    @Published var emotions: [String] = []
    @Published var selectedEmotions: [String] = []
    @Published var contexts: [String] = []
    @Published var selectedContexts: [String] = []
    @Published var emotionField = ""
    @Published var contextField = ""
    @Published var isComplete = false
    let provider = MoyaProvider<PostAPI>()
    
//    private lazy var service = MoyaProvider<PostAPI>()
    var disposeBag = DisposeBag()
    
    init(isControl: Bool = false) {
        self.isControl = isControl
    }
    
    
    func newPost(text: String) {
            
        provider.rx.request(.newPost(text: text))
            .map(PostData.self)
            .subscribe(
                onSuccess: { data in
                    // save department list in raw
                    self.emotions = [data.sentiment]
                    self.contexts = data.keywords
                    self.isComplete = true
                },
                onError: {
                    print("==== error: \($0)")
                }
            ).disposed(by: disposeBag)

    }
    
    func clearInputs() {
        emotions = []
        selectedEmotions = []
        contexts = []
        selectedContexts = []
        emotionField = ""
        contextField = ""
        self.isComplete = false
    }

    
    
    
          
}
    
    
    
