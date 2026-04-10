//
//  ViewController.swift
//  ChildVCTransition
//
//  Created by Metalien on 2026/4/10.
//

import UIKit

let NotificationCenterJumpViewController = "NotificationCenterJumpViewController"

class ViewController: UIViewController {
    
    var currentIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 创建视图
        setupChildViewController()
        // 创建通知中心
        setupNotificationCenter()
    }

    // 创建视图
    private func setupChildViewController() {
        
        // 添加子视图控制器
        addChild(FirstViewController())
        addChild(SecondViewController())
        // 添加视图
        view.addSubview((children.first?.view)!)
        
    }
    
    // 创建通知中心
    private func setupNotificationCenter() {
        // 跳转视图控制器
        NotificationCenter.default.addObserver(self, selector: #selector(jumpViewController), name: NSNotification.Name(rawValue: NotificationCenterJumpViewController), object: nil)
    }
    
    
    // MARK: Notification Event
    
    @objc private func jumpViewController() {
        // options: 跳转方式
        
        let fromVC = (currentIndex == 0 ? children.first! : children.last!)
        let toVC = (currentIndex == 0 ? children.last! : children.first!)
        let options = (currentIndex == 0 ? UIView.AnimationOptions.transitionFlipFromLeft : UIView.AnimationOptions.transitionFlipFromRight)
        
        transition(from: fromVC, to: toVC, duration: 1.0, options: options, animations: nil)
        
        currentIndex = (currentIndex == 0 ? 1:0)
    }
    
    // MARK: Deinit
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: NotificationCenterJumpViewController), object: nil)
    }
    
}

