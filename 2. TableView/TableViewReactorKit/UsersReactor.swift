//
//  UsersReactor.swift
//  TableVIewReactorKit
//
//  Created by Juyeon on 2021/08/20.
//

import Foundation
import ReactorKit

class UsersReactor: Reactor {
    enum Action {
        case readUsers
    }
    
    enum Mutation {
        case setUsers([UserModel])
    }
    
    struct State {
        var users: [UserModel] = []
    }
    
    let initialState: State = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .readUsers:
            return APIManager.shared.readUsers()
                .map { Mutation.setUsers($0) }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setUsers(users): newState.users = users
        }
        return newState
    }
}
