//
//  CustomTabBarController.swift
//  TabbarController
//
//  Created by Metalien on 2026/6/8.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 创建视图
        setupSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 默认选中
        selectedIndex = 1
        selectedViewController = viewControllers?[selectedIndex]
    }
    
    // 创建视图
    private func setupSubviews() {
        
        let aVC = AViewController()
        aVC.title = "A Page"
        aVC.tabBarItem.title = "A"
        aVC.tabBarItem.image = UIImage(named: "Game")
        
        let bVC = BViewController()
        bVC.title = "B Page"
        bVC.tabBarItem.title = "B"
        bVC.tabBarItem.image = UIImage(named: "Home")
        
        let cVC = CViewController()
        cVC.title = "C Page"
        cVC.tabBarItem.title = "C"
        cVC.tabBarItem.image = UIImage(named: "Setting")
        
        viewControllers = [aVC, bVC, cVC]
    }

}
