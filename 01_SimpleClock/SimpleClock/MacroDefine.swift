//
//  Macro.swift
//  SimpleClock
//
//  Created by Metalien on 2026/1/8.
//

import Foundation
import UIKit

enum MacroScreen {
    static func bounds(in view: UIView) -> CGRect {
        if view.bounds != .zero {
            return view.bounds
        }
        return view.window?.windowScene?.screen.bounds ?? .zero
    }

    static func width(in view: UIView) -> CGFloat {
        bounds(in: view).width
    }

    static func height(in view: UIView) -> CGFloat {
        bounds(in: view).height
    }
}





