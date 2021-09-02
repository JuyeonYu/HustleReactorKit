//
//  EditClubReactor.swift
//  TableVIewReactorKit
//
//  Created by Juyeon on 2021/09/01.
//

import Foundation
import ReactorKit

class EditClubReactor: Reactor {
    enum Action {
        case edit(name: String)
    }
    enum Mutation {
        case set(name: String)
        case edit(name: String)
    }
    struct State {
        var name = ""
    }
    var initialState = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .edit(name: let name):
            return Observable.just(Mutation.edit(name: name))
        }
    }
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .set(name: name):
            newState.name = name
        case let .edit(name: name):
            UserInfo.name.onNext(name)
        }
        return newState
    }
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        return Observable.merge(mutation, UserInfo.name.map { Mutation.set(name: $0) })
    }
}
