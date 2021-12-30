//
//  StreamUseCase.swift
//  collaborativeCBT
//
//  Created by Subeen Park on 2021/12/30.
//
// Ref: https://ios-development.tistory.com/232

import Foundation
import Firebase

protocol StreamUseCase {
    associatedtype Response

    var path: String { get }

    func subscribe(query: String, completion: @escaping (Result<Response, StreamError>) -> Void)
    func removeListener()
}
