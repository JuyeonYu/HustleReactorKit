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
    
    func readUsers() -> Observable<[UserModel]> {
        return provider.rx.request(.users)
            .map([UserModel].self)
            .asObservable()
    }
    func readPosts() -> Observable<[PostModel]> {
        return provider.rx.request(.posts)
            .map([PostModel].self)
            .asObservable()
    }

}
