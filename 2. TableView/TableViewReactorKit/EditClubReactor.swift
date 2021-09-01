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
        case setName(name: String)
    }
    struct State {
        var name: String
    }
    var initialState: State
    
    
    init(user: String) {
        initialState = State(name: user)
    }
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .edit(name: let name):
            return Observable.just(Mutation.setName(name: name))
        }
    }
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setName(name: let name):
            newState.name = name
        }
        return newState
    }
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        return Observable.merge(mutation, )
    }
}
