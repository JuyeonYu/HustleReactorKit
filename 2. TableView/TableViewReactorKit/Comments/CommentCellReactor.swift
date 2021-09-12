//
//  CommentCellReactor.swift
//  TableVIewReactorKit
//
//  Created by Juyeon on 2021/09/12.
//

import Foundation
import ReactorKit

class CommentCellReactor: Reactor {
    
    typealias Action = NoAction
    
    var initialState: State
    
    struct State {
        var body: String
        var name: String
        var mail: String
    }
    
    init(comment: CommentModel) {
        self.initialState = State(body: comment.body,
                                  name: comment.name,
                                  mail: comment.email)
    }
}
