//
//  CustomTableViewCell.swift
//  SwipeableCell
//
//  Created by Chausang on 2026/5/6.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    
    public func prepareCell(model: CellModel) {
        imageView?.image = UIImage(named: model.imageName)
        textLabel?.text = model.title
        textLabel?.textAlignment = .center
    }
    

}
