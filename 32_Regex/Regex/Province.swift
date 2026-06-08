//
//  Province.swift
//  Regex
//
//  Created by Metalien on 2026/6/8.
//

import Foundation

struct City {
    let name: String
    let alias: String
}

struct Province {
    let name: String
    var citys: [City]
}

