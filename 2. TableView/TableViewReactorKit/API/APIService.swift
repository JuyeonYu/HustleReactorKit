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
}

extension APIService: TargetType {
    var baseURL: URL {
        switch self {
        case .users: return URL(string: "https://jsonplaceholder.typicode.com/")!
        }

    }
    
    var path: String {
        switch self {
        case .users: return "users"
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
