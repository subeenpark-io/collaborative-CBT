//
//  PostAPI.swift
//  collaborativeCBT
//
//  Created by Subeen Park on 2021/08/31.
//

import Foundation
import Moya
import RxSwift

enum PostAPI {
    case newPost(text: String)
}


extension PostAPI: TargetType {
    
    var baseURL: URL {
        guard let url = URL(string: BaseAPI.baseURL) else {
            fatalError()
        }
        return url
    }
    
    var path: String {
        switch self {
        case .newPost:
            return "/predict"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .newPost:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .newPost(let text):
            return .requestParameters(parameters: ["content": text], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .newPost:
            return ["Content-Type": "application/json"]
        }
        
    }
    
    
}


