//
//  CommentReactor.swift
//  TableVIewReactorKit
//
//  Created by Juyeon on 2021/08/29.
//

import Foundation
import ReactorKit

class CommentReactor: Reactor {
    enum Action {
         case readComments
    }
    enum Mutation {
        case setComments([CommentModel])
        case setPosts([PostModel])
    }
    struct State {
        var comments: [CommentModel] = []
        var posts: [PostModel] = []
        var sections: [MultipleSectionModel] = []
    }
    var initialState: State = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .readComments:
            return .concat([
                APIManager.shared.readComments()
                    .map { .setComments($0) },
                APIManager.shared.readPosts()
                    .map { .setPosts($0)}
            ])
        }
    }
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setComments(let comments):
            newState.sections.append(
                .CommentSection(title: "comments",
                                items: comments.map { .CommentSectionItem($0) }
                ))
        case .setPosts(let posts):
            newState.sections.append(
                .PostSection(title: "posts",
                             items: posts.map { .PostSectionItem($0) }))
        }
        return newState
    }
}
