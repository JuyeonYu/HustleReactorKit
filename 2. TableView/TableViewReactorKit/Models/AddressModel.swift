//
//  AddressModel.swift
//  TableVIewReactorKit
//
//  Created by Juyeon on 2021/08/20.
//

import Foundation
struct AddressModel: Codable {
    let street, suite, city, zipcode: String
    let geo: GeoModel
}
