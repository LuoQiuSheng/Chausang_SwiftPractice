//
//  CustomModel.swift
//  CollectionViewAnimation
//
//  Created by Metalien on 2026/4/21.
//

import Foundation

// 数据结构体
struct CustomModel {
    
    let imageName: String
    let title: String
    
    init(imageName: String, title: String) {
        self.imageName = imageName
        self.title = title
    }
    
    static func getModel() -> [CustomModel]? {
        
        let txt = "英烈安葬地准备就绪，静待英雄回家。沈阳抗美援朝烈士陵园目前已完成各项准备工作，园区庄严肃穆、井然有序，静待英雄回家"
        let imageNames = ["1", "2", "3", "4", "5"]
        let titles = Array(repeating: txt, count: imageNames.count)
        
        var result = [CustomModel]()
        for (index, name) in imageNames.enumerated() {
            let tempModel = CustomModel(imageName: name, title: titles[index])
            result.append(tempModel)
        }
        return result
    }
    
}


/**
 
 struct UserModel: Codable {
     let id: Int
     let name: String
     let age: Int
 }
 
 
 let dict: NSDictionary = [
     "id": 1001,
     "name": "小红",
     "age": 18
 ]

 // 转换
 do {
     // 先转 Data
     let data = try JSONSerialization.data(withJSONObject: dict)
     // 再转模型
     let user = try JSONDecoder().decode(UserModel.self, from: data)
     print(user.name)
 } catch {
     print("解析失败：", error)
 }
 
 
 */
