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
    
    func readTime() -> Observable<TimeModel> {
        return provider.rx.request(.time)
            .map(TimeModel.self)
            .asObservable()
    }
}
