//
//  FirestoreManager.swift
//  collaborativeCBT
//
//  Created by Subeen Park on 2021/12/31.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


final class FirestoreManager {
    
    enum PostType: String {
        case control = "control"
        case experiment = "experiment"
    }
    
    private var documentListener: ListenerRegistration?
    
    func save(_ post: Post, postType: PostType, completion: ((Error?) -> Void)? = nil) {
        let collectionPath = "\(postType.rawValue)"
        let collectionListener = Firestore.firestore().collection(collectionPath)
        
        guard let dictionary = post.asDictionary else {
            print("decode error")
            return
        }
        collectionListener.addDocument(data: dictionary) { error in
            completion?(error)
        }
    }
    
    func updateComment(_ post: Post, postType: PostType, comment: String, completion: ((Error?) -> Void)? = nil) {
        
        let collectionPath = "\(postType.rawValue)"
        let collectionListener = Firestore.firestore().collection(collectionPath)
        
        post.comments.append(Comment(content: comment))
        print(post.comments)
        
        post.comments.forEach {
            print($0.createdAt)
        }
        
        guard let dictionary = post.asDictionary else {
            print("decode error")
            return
        }
        
        collectionListener.whereField("id", isEqualTo: post.id).getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            }
            else {
                querySnapshot!.documents.forEach { document in
                    document.reference.updateData(dictionary) { error in
                        completion?(error)
                        
                    }
                }
            }
            
        }
        
    }

    func subscribe(postType: PostType, completion: @escaping (Result<[Post], FirestoreError>) -> Void) {
        
        print("Subscription Triggered")
        let collectionPath = "\(postType.rawValue)"
        removeListener()
        let collectionListener = Firestore.firestore().collection(collectionPath)
        
        documentListener = collectionListener
            .addSnapshotListener { snapshot, error in
                guard let snapshot = snapshot else {
                    completion(.failure(FirestoreError.firestoreError(error)))
                    return
                }
                
                var posts = [Post]()
                snapshot.documentChanges.forEach { change in
                    switch change.type {
                    case .added, .modified:
                        do {
                            if let post = try change.document.data(as: Post.self) {
                                posts.append(post)
                                print("POSTS RENEWED -- Firestore Manager")

                            }
                        } catch {
                            completion(.failure(.decodedError(error)))
                        }
                    default: break
                    }
                }
                completion(.success(posts))
            }
    }
    
    func removeListener() {
        documentListener?.remove()
    }
}
