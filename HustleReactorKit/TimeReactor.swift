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
        case clear
    }
    
    enum Mutation {
        case setTime(String)
    }
    
    struct State {
        static let timePlaceHolder = "몇 시 일까요?"
        var time: String = timePlaceHolder
        var hasTime: Bool = false
    }
    
    let initialState: State = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .readTime:
            return Observable.concat([
                Observable.just(Mutation.setTime("Loading...")),
                APIManager.shared.readTime()
                    .map { Mutation.setTime($0) }
            ])
        case .clear:
            return Observable.just(Mutation.setTime(State.timePlaceHolder))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setTime(time):
            newState.time = time
            newState.hasTime = time != State.timePlaceHolder
        }
        return newState
    }
}
