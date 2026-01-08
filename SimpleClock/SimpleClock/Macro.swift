//
//  Macro.swift
//  SimpleClock
//
//  Created by Metalien on 2026/1/8.
//

import Foundation
import UIKit

enum MacroScreen {
    
    static func bounds(in scene: UIWindowScene?) -> CGRect {
        scene?.screen.bounds ?? .zero
    }
    
    static var currentBounds: CGRect {
        UIApplication.shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .screen
            .bounds ?? .zero
    }
}


