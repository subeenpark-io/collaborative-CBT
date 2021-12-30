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
    @Published var posts: [Post] = []
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
    
    let myFirestore = FirestoreManager()
    
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
    
    func savePost(body: String) {
        
        let post = Post(emotions: selectedEmotions, contexts: selectedContexts, body: body, comments: [])
        myFirestore.save(post, postType: isControl ? .control : .experiment) {  error in
            print("error: \(error)")
        }
            
    }
    
    func addComments(post: Post, comment: String) {
        myFirestore.updateComment(post, postType: isControl ? .control : .experiment, comment: comment) { error in
            print("error: \(error)")
        }
    }
    
    func subscribeFirestore() {
        myFirestore.subscribe(postType: isControl ? .control : .experiment) { [weak self] result in
            switch result {
            case .success(let newPosts):
//                print("POSTS RENEWE \(posts)D")
//                print("POST IDS == ")
                let newPostIds = newPosts.map({$0.id})
                self!.posts = self!.posts.filter({ !newPostIds.contains($0.id) })
                self!.posts.append(contentsOf: newPosts)
                self!.posts = self!.posts.sorted(by: {
                    $0 < $1
                })
            case .failure(let error):
                print(error)
            }
        }
    }

    
    
    
          
}
    
    
    
