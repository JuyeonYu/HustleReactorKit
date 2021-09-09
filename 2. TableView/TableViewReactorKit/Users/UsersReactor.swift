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
        case onFilter(Int)
    }
    
    enum Mutation {
        case setUsers([UserModel])
        case setFileter(Int)
    }
    
    struct State {
        var users: [UserModel] = []
    }
    
    let initialState: State = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .readUsers:
            return APIManager.shared.readUsers()
                .map { .setUsers($0) }
        case .onFilter(let id):
            return .just(.setFileter(id))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setUsers(users): newState.users = users
        case .setFileter(let id):
            if id == 1 {
                newState.users = newState.users.filter {
                    $0.name.count % 2 == 0
                }
            } else {
                newState.users = newState.users.filter {
                    $0.name.count % 3 == 0
                }
            }
        }
        return newState
    }
}
