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
        case readPosts
    }
    
    enum Mutation {
        case setPosts([PostModel])
    }
    
    struct State {
        var posts: [PostModel] = []
    }
    
    var initialState: State = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .readPosts: return APIManager.shared.readPosts()
            .map { Mutation.setPosts($0) }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setPosts(posts): newState.posts = posts
        }
        return newState
    }
    
}
