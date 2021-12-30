//
//  FirestoreError.swift
//  collaborativeCBT
//
//  Created by Subeen Park on 2021/12/31.
//

import Foundation

enum FirestoreError: Error {
    case firestoreError(Error?)
    case decodedError(Error?)
}
