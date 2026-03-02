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

}
