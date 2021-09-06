//
//  PostModel.swift
//  TableVIewReactorKit
//
//  Created by Juyeon on 2021/08/23.
//

import Foundation
struct PostModel: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
    var bookmark: Bool? = false
}
