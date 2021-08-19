//
//  APIManager.swift
//  HustleReactorKit
//
//  Created by Juyeon on 2021/08/19.
//

import Foundation
import Moya
import RxSwift

class APIManager {
    init() {}
    static let shared = APIManager()
    private let provider = MoyaProvider<APIService>()
    
    func readTime() -> Observable<String> {
        return provider.rx.request(.time)
            .map(TimeModel.self)
            .map { $0.unixtime }
            .map { Date.init(timeIntervalSince1970: TimeInterval($0)) }
            .map {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                return dateFormatter.string(from: $0)
            }
            .asObservable()
    }
}
