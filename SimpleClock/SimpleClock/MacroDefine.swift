//
//  Macro.swift
//  SimpleClock
//
//  Created by Metalien on 2026/1/8.
//

import Foundation
import UIKit



enum MacroScreen {
    /// 当前可用的 UIScreen（完全基于 Scene / Context）
    private static var currentScreen: UIScreen? {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first { $0.activationState == .foregroundActive }?
            .screen
    }
    /// 当前屏幕 bounds（无 main、无警告）
    static var bounds: CGRect {
        currentScreen?.bounds ?? .zero
    }
    /// 屏幕宽度
    static var width: CGFloat {
        bounds.width
    }
    /// 屏幕高度
    static var height: CGFloat {
        bounds.height
    }
}



