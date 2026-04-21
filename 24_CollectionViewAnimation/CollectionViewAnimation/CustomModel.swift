//
//  CustomModel.swift
//  CollectionViewAnimation
//
//  Created by Metalien on 2026/4/21.
//

import Foundation

// 数据结构体
struct CustomModel {
    
    let imageView: String
    let title: String
    
    init(imageView: String, title: String) {
        self.imageView = imageView
        self.title = title
    }
    
    static func getModel() -> [CustomModel]? {
        
        let txt = "英烈安葬地准备就绪，静待英雄回家。沈阳抗美援朝烈士陵园目前已完成各项准备工作，园区庄严肃穆、井然有序，静待英雄回家"
        let imageNames = ["1", "2", "3", "4", "5"]
        let titles = Array(repeating: txt, count: imageNames.count)
        
        var result = [CustomModel]()
        for (index, name) in imageNames.enumerated() {
            let tempModel = CustomModel(imageView: name, title: titles[index])
            result.append(tempModel)
        }
        return result
    }
    
}
