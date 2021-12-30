//
//  StreamError.swift
//  collaborativeCBT
//
//  Created by Subeen Park on 2021/12/30.
//
// Ref: https://ios-development.tistory.com/232

import Foundation

public enum StreamError: Error {
    case notFound
    case wrongGettingDocument(Error)
    case decoderError
}
