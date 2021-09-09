//
//  PostsReactor.swift
//  TableVIewReactorKit
//
//  Created by Juyeon on 2021/08/23.
//

import Foundation
import ReactorKit

class PostsReactor: Reactor {
    enum Action {
        case loadMore
        case readPosts
        case obBookmark(Int)
    }
    
    enum Mutation {
        case setPosts([PostModel])
        case setBookmark(Int)
        case setPage(Int)
    }
    
    struct State {
        var posts: [PostModel] = []
        var page = 0
    }
    
    var initialState: State = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .readPosts: return APIManager.shared.readPosts()
            .map { Mutation.setPosts($0) }
        case .obBookmark(let row):
            return Observable.just(.setBookmark(row))
        case .loadMore: return .just(.setPage(currentState.page + 1))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setPosts(posts): newState.posts = posts
        case let .setBookmark(row): newState.posts[row].bookmark = !(currentState.posts[row].bookmark ?? false)
        case let .setPage(page): newState.page = page
        }
        return newState
    }
}
