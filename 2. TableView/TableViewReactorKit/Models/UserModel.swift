//
//  UserModel.swift
//  TableVIewReactorKit
//
//  Created by Juyeon on 2021/08/20.
//

import Foundation
import RxSwift

struct UserModel: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: AddressModel
    let phone: String
    let website: String
    let company: CompanyModel
}

class UserInfo {
    static var name = BehaviorSubject<String>(value: "")
}
