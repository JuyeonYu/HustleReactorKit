//
//  TimeReactor.swift
//  HustleReactorKit
//
//  Created by Juyeon on 2021/08/19.
//

import Foundation
import ReactorKit

class TimeReactor: Reactor {
    enum Action {
        case readTime
    }
    
    enum Mutation {
        case setTime(String)
    }
    
    struct State {
        var time: String = ""
    }
    
    let initialState: State = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .readTime:
            return Observable.concat([
                Observable.just(Mutation.setTime("Loading...")),
                APIManager.shared.readTime()
                    .map { $0.datetime }
                    .map { Mutation.setTime($0) }
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setTime(time): newState.time = time
        }
        return newState
    }
}
