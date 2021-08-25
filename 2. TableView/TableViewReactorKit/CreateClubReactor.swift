//
//  TestReactor.swift
//  TableVIewReactorKit
//
//  Created by Juyeon on 2021/08/25.
//

import Foundation
import ReactorKit

class CreateClubReactor: Reactor {
    enum Action {
        case inputName(String)
    }
    enum Mutation {
        case setName(String)
        case setNameState(NameState)
    }
    struct State {
        var name = ""
        var nameState: NameState = .invalid(.short)
        var helpMessage = ""
        var separatorColor = UIColor.gray
    }
    enum NameState: Equatable {
        case valid
        case invalid(InvalidType)
        
        static func == (lhs: Self, rhs: Self) -> Bool {
                switch (lhs, rhs) {
                case (.valid, .valid),
                     (.invalid, .invalid):
                    return true
                default:
                    return false
                }
            }
    }
    enum InvalidType {
        case short
        case long
        case duplicated
    }
    
    var initialState: State = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .inputName(let name):
            guard name.count > 3 else {
                return Observable.concat([
                    Observable.just(Mutation.setNameState(.invalid(.short))),
                    Observable.just(Mutation.setName(name))
                ])
            }
            guard name.count < 11 else {
                return Observable.concat([
                    Observable.just(Mutation.setNameState(.invalid(.long))),
                    Observable.just(Mutation.setName(name))
                ])
            }
            return Observable.concat([
                Observable.just(Mutation.setNameState(.valid)),
                Observable.just(Mutation.setName(name))
            ])
        }
    }
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setName(let name):
            newState.name = name
        case .setNameState(let nameState):
            newState.nameState = nameState
            switch nameState {
            case .valid:
                newState.separatorColor = .gray
                newState.helpMessage = ""
            case .invalid(let invalidType):
                newState.separatorColor = .red
                switch invalidType {
                case .short:
                    newState.helpMessage = "짧"
                case .long:
                    newState.helpMessage = "길"
                case .duplicated:
                    newState.helpMessage = "중"
                }
            }
        }
        return newState
    }
}
