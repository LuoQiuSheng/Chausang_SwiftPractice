//
//  PictureBrowseModel.swift
//  PictureBrowse
//
//  Created by Metalien on 2026/3/2.
//

import UIKit

class PictureBrowseModel: NSObject {
    
    var title: String?
    var descriptions: String?
    var featuredImage: UIImage?
    
    init(title: String? = nil, descriptions: String? = nil, featuredImage: UIImage? = nil) {
        self.title = title
        self.descriptions = descriptions
        self.featuredImage = featuredImage
    }
    
    
    static func createPictureBrowseModels() -> [PictureBrowseModel] {
        return [
//            PictureBrowseModel(title: "xxxxxx", descriptions: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", featuredImage: UIImage(named: "blue")),
            PictureBrowseModel(title: "xxxxxx", descriptions: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", featuredImage: UIImage(named: "bodyline")),
            PictureBrowseModel(title: "xxxxxx", descriptions: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", featuredImage: UIImage(named: "darkvarder")),
            PictureBrowseModel(title: "xxxxxx", descriptions: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", featuredImage: UIImage(named: "dudu")),
            PictureBrowseModel(title: "xxxxxx", descriptions: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", featuredImage: UIImage(named: "hello")),
            PictureBrowseModel(title: "xxxxxx", descriptions: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", featuredImage: UIImage(named: "hhhhh")),
            PictureBrowseModel(title: "xxxxxx", descriptions: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", featuredImage: UIImage(named: "wave")),
        ]
    }
    

}
