//
//  ProvinceModel.swift
//  SearchVC
//
//  Created by Metalien on 2026/6/15.
//

import Foundation


struct City {
    let name: String
    let alias: String
}

struct ProvinceModel {
    var name: String
    var pinyin: String
    var citys: [City]
}
