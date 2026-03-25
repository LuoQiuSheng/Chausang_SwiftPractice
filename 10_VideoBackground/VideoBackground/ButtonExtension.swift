//
//  ButtonExtension.swift
//  VideoBackground
//
//  Created by Metalien on 2026/3/25.
//

import Foundation
import UIKit

extension UIButton {
    
    func customWhiteLayerButton(title: String) {
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 5.0
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1.0
    }
}
