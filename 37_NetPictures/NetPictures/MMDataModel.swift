//
//  FemaleModel.swift
//  NetPictures
//
//  Created by Metalien on 2026/6/25.
//

import Foundation


struct MMDataModel {
    
    let nickname: String
    let height: String
    let weight: String
    let bwh: String
    let birthday: String
    let pictureCount: Int
    let headerUrl: String
    let headImageFilename: String
    let title: String
    let issue: Int
    let catalog: String
    let ID: Int
    
    // 解析数据
    static func parseData(data: Any?) -> [MMDataModel] {
        // 解析数据
        let dic = data as! NSDictionary
        let data = dic["data"] as! NSDictionary
        let list = data["list"] as! NSArray
        // 集合
        var result = [MMDataModel]()
        // 遍历
        for mm in list {
            let mm = mm as! NSDictionary
            print(mm)
            let mmSource = mm["source"] as! NSDictionary
            let mmAuthor = mm["author"] as! NSDictionary
            let mmdata = MMDataModel(nickname: mmAuthor["nickname"] as! String,
                                     height: mmAuthor["height"] as! String,
                                     weight: mmAuthor["weight"] as! String,
                                     bwh: mmAuthor["bwh"] as! String,
                                     birthday: mmAuthor["birthday"] as! String,
                                     pictureCount: mm["pictureCount"] as! Int,
                                     headerUrl: mmAuthor["headerUrl"] as! String,
                                     headImageFilename: mm["headImageFilename"] as! String,
                                     title: mm["title"] as! String,
                                     issue: mm["issue"] as! Int,
                                     catalog: mmSource["catalog"] as! String,
                                     ID: mm["id"] as! Int)
            result.append(mmdata)
        }
        return result
    }
}
