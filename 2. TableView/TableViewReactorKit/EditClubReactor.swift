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
    }
    struct State {
        var name = ""
    }
    var initialState = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .edit(name: let name):
            UserInfo.name.onNext(name)
            return .just(.set(name: name))
        }
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        return Observable.merge(mutation, UserInfo.name.map { Mutation.set(name: $0) })
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .set(name: let name):
            newState.name = name
        }
        return newState
    }
}
