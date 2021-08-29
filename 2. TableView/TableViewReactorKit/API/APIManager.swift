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
    func readUser(id: Int) -> Observable<String> {
        return provider.rx.request(.user(id))
            .map(UserModel.self)
            .map { $0.username }
            .asObservable()
    }
    func readPosts() -> Observable<[PostModel]> {
        return provider.rx.request(.posts)
            .map([PostModel].self)
            .asObservable()
    }
    func readComments() -> Observable<[CommentModel]> {
        return provider.rx.request(.comments)
            .map([CommentModel].self)
            .asObservable()
    }

}
