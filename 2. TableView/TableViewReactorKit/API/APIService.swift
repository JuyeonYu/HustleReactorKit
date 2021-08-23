//
//  APIService.swift
//  HustleReactorKit
//
//  Created by Juyeon on 2021/08/19.
//

import Foundation
import Moya

enum APIService {
    case users
    case user(Int)
    case posts
}

extension APIService: TargetType {
    var baseURL: URL {
        URL(string: "https://jsonplaceholder.typicode.com/")!
    }
    
    var path: String {
        switch self {
        case .users: return "users"
        case let .user(id): return "users/\(id)"
        case .posts: return "posts"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Task {
        .requestPlain
    }
    
    var headers: [String : String]? {
        nil
    }
}
