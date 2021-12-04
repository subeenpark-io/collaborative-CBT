//
//  Post.swift
//  collaborativeCBT
//
//  Created by Subeen Park on 2021/12/05.
//

import Foundation

class Post: ObservableObject, Identifiable, Hashable {
    
    let id = UUID()
    
    init(emotions: [String], contexts: [String], body: String, comments: [String]) {
        self.emotions = emotions
        self.contexts = contexts
        self.body = body
        self.comments = comments
    }
    
    var emotions: [String]
    var contexts: [String]
    var body: String
    @Published var comments: [String]
    
    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(body)
    }
}
