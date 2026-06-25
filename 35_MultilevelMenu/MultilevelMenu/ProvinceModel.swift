//
//  ProvinceModel.swift
//  MultilevelMenu
//
//  Created by Metalien on 2026/6/25.
//

import Foundation


struct CityModel {
    let name: String
    let alias: String
}

struct ProvinceModel {
    let name: String
    var citys: [CityModel]
    var isOpen: Bool
}

func getAllProvinceData() -> [ProvinceModel] {
    var tempDataSource = [ProvinceModel]()
    guard let path = Bundle.main.path(forResource: "Province", ofType: "plist"),
          let dic = NSDictionary(contentsOfFile: path) else {
        return tempDataSource
    }
    dic.enumerateKeysAndObjects { key, value, _ in
        guard let values = value as? NSDictionary else { return }
        var citys = [CityModel]()
        for k in values.allKeys {
            guard let cityName = k as? String,
                  let alias = values[k] as? String else { continue }
            let city = CityModel(name: cityName, alias: alias)
            citys.append(city)
        }
        guard let proName = key as? String else { return }
        let pro = ProvinceModel(name: proName, citys: citys, isOpen: false)
        tempDataSource.append(pro)
    }
    return tempDataSource
}


