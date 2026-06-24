//
//  ScreenSizeUtils.swift
//  CurrentLocation
//
//  Created by Metalien on 2026/3/3.
//

import UIKit

class ScreenSizeUtils: NSObject {
    
    /// 屏幕宽度
    static let SCREEN_WIDTH = UIScreen.main.bounds.width
    /// 屏幕高度
    static let SCREEN_HEIGHT = UIScreen.main.bounds.height
    
    /// 状态栏高度（计算属性不能是静态存储属性，需要是计算属性）
    static var STATUSBAR_HEIGHT: CGFloat {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            return UIApplication.shared.statusBarFrame.height
        }
    }
    
    /// 顶部安全距离
    static var TopSafeAreaHeight: CGFloat {
        return UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
    }
    
    /// 底部安全距离
    static var BottomSafeAreaHeight: CGFloat {
        return UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
    }
    
    /// 导航栏高度
    static var NAVGATION_HEIGHT: CGFloat {
        guard let window = UIApplication.shared.windows.first else {
            return 0
        }
        
        let topSafeAreaInset = window.safeAreaInsets.top
        let navigationBarHeight: CGFloat = 44
        
        if topSafeAreaInset > 0 {
            return topSafeAreaInset + navigationBarHeight
        } else {
            let statusBarHeight = window.windowScene?.statusBarManager?.statusBarFrame.height ?? 20
            return statusBarHeight + navigationBarHeight
        }
    }
    
    /// tabbar高度
    static var TABBAR_HEIGHT: CGFloat {
        return BottomSafeAreaHeight + 49
    }

}
