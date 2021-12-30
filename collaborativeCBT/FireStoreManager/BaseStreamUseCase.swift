//
//  BaseStreamUseCase.swift
//  collaborativeCBT
//
//  Created by Subeen Park on 2021/12/30.
//
// Ref: https://ios-development.tistory.com/232

import Foundation
import Firebase
import FirebaseFirestoreSwift

public class BaseStreamUseCase<ResponseType: Codable>: StreamUseCase {
    public typealias Response = ResponseType
    var path: String {
        return "require the path"
    }

    private var listenerObject: ListenerRegistration?
    private let db: Firestore
    public init(db: Firestore) {
        self.db = db
    }

    public func subscribe(query: String, completion: @escaping (Result<Response, StreamError>) -> Void) {

        listenerObject = db.collection(path).document(query)
            .addSnapshotListener { (querySnapshot, error) in

                guard let querySnapshot = querySnapshot else {
                    completion(.failure(.notFound))
                    return
                }

                if let error = error {
                    completion(.failure(.wrongGettingDocument(error)))
                    return
                }

                guard let data = try? querySnapshot.data(as: Response.self) else {
                    completion(.failure(.decoderError))
                    return
                }

                completion(.success(data))
            }
    }

    public func removeListener() {
        listenerObject?.remove()
    }
}
