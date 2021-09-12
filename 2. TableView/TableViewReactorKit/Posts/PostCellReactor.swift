//
//  PostCellReactor.swift
//  TableVIewReactorKit
//
//  Created by Juyeon on 2021/09/12.
//

import Foundation
import ReactorKit

class PostCellReactor: Reactor {
    typealias Action = NoAction
    
    struct State {
        var title: String
        var body: String
        var isBookmarked: Bool = false
    }
    
    var initialState: State
    
    init(title: String, body: String) {
        self.initialState = State(title: title, body: body)
    }
}
