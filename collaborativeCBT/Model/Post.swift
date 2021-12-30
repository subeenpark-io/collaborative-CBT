//
//  Post.swift
//  collaborativeCBT
//
//  Created by Subeen Park on 2021/12/05.
//

import UIKit
import Firebase
import FirebaseFirestore

class Post: ObservableObject, Codable {
    
    var id: String
    
    init(emotions: [String], contexts: [String], body: String, comments: [Comment]) {
        self.id = UUID().uuidString
        self.emotions = emotions
        self.contexts = contexts
        self.body = body
        self.comments = comments
        self.createdAt = Date()
        self.writer = UIDevice.current.identifierForVendor!.uuidString
    }
    
    var emotions: [String]
    var contexts: [String]
    var body: String
    var createdAt: Date
//    @Published var comments: [String]
    var comments: [Comment]
    var writer: String
    
    
    private enum CodingKeys: String, CodingKey {
        case id
        case emotions
        case contexts
        case body
        case createdAt
        case comments
        case writer
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(String.self, forKey: .id)
        emotions = try container.decode([String].self, forKey: .emotions)
        contexts = try container.decode([String].self, forKey: .contexts)
        body = try container.decode(String.self, forKey: .body)
        writer = try container.decode(String.self, forKey: .writer)
        
        let dataDouble = try container.decode(Timestamp.self, forKey: .createdAt)
        createdAt = dataDouble.dateValue()
        
        comments = try container.decode([Comment].self, forKey: .comments).sorted(by: {
            $0 < $1
        })
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(emotions, forKey: .emotions)
        try container.encode(contexts, forKey: .contexts)
        try container.encode(body, forKey: .body)
        try container.encode(Timestamp(date: createdAt), forKey: .createdAt)
        try container.encode(comments, forKey: .comments)
        try container.encode(writer, forKey: .writer)
    }


}


extension Post: Comparable, Identifiable {
    
    static func < (lhs: Post, rhs: Post) -> Bool {
        return lhs.createdAt < rhs.createdAt
    }
    
    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.id
    }

}

extension Post: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(body)
    }
    
}
