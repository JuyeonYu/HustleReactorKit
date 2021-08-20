//
//  APIService.swift
//  HustleReactorKit
//
//  Created by Juyeon on 2021/08/19.
//

import Foundation
import Moya

enum APIService {
    case time
}

extension APIService: TargetType {
    var baseURL: URL {
        URL(string: "https://worldtimeapi.org/")!
    }
    
    var path: String {
        switch self {
        case .time: return "api/timezone/Asia/Seoul"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .time: return .get
        }
        
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
