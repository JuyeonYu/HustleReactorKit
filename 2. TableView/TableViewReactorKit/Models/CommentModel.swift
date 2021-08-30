//
//  CommentModel.swift
//  TableVIewReactorKit
//
//  Created by Juyeon on 2021/08/29.
//

import Foundation
struct CommentModel: Codable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}
