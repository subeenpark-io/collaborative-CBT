//
//  Comment.swift
//  collaborativeCBT
//
//  Created by Subeen Park on 2021/12/31.
//

import Foundation
import Firebase
import FirebaseFirestore

class Comment: ObservableObject, Codable {
    
    var id: String
    var content: String
    var createdAt: Date
    var writer = UIDevice.current.identifierForVendor!.uuidString
    
    init(content: String) {
        self.id = UUID().uuidString
        self.content = content
        self.createdAt = Date()
        self.writer = UIDevice.current.identifierForVendor!.uuidString
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case content
        case createdAt
        case writer
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(String.self, forKey: .id)
        content = try container.decode(String.self, forKey: .content)
        
        let dataDouble = try container.decode(Timestamp.self, forKey: .createdAt)
        createdAt = dataDouble.dateValue()
        writer = try container.decode(String.self, forKey: .writer)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(content, forKey: .content)
        try container.encode(Timestamp(date: createdAt), forKey: .createdAt)
        try container.encode(writer, forKey: .writer)
    }


}

extension Comment: Comparable, Identifiable {
    
    static func < (lhs: Comment, rhs: Comment) -> Bool {
        return lhs.createdAt < rhs.createdAt
    }
    
    static func == (lhs: Comment, rhs: Comment) -> Bool {
        return lhs.id == rhs.id
    }

}

extension Comment: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(content)
    }
    
}
