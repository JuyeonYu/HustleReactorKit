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
        var filteredUsers: [UserModel] = []
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
        case let .setUsers(users):
            newState.users = users
            newState.filteredUsers = users
        case .setFileter(let id):
            if id == 1 {
                newState.filteredUsers = newState.users.filter {
                    $0.id % 2 == 0
                }
            } else {
                newState.filteredUsers = newState.users.filter {
                    $0.id % 2 == 1
                }
            }
        }
        return newState
    }
}
