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
        case setComments([SectionOfCustomData])
    }
    struct State {
        var comments: [CommentModel] = []
        var posts: [PostModel] = []
        var sections: [SectionOfCustomData] = []
    }
    var initialState: State = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .readComments:
            return APIManager.shared.readComments()
                .map { Mutation.setComments([SectionOfCustomData(header: "reply", items: $0)]) }
        }
    }
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setComments(let comments): newState.sections = comments
        }
        return newState
    }
}
