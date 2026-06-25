//
//  UITapGestureRecognizer+Extension.swift
//  MultilevelMenu
//
//  Created by Metalien on 2026/6/25.
//

import UIKit

// 采用 runtime 为手势增加一个 tag 属性，标记手势
extension UITapGestureRecognizer {
    
    struct AddProperty {
        static var tag: Int = 0
    }
    
    var tag: Int {
        get {
            return objc_getAssociatedObject(self, &AddProperty.tag) as! Int
        }
        set {
            objc_setAssociatedObject(self, &AddProperty.tag, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
}
