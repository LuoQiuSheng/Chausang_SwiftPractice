//
//  FirstViewController.swift
//  ChildVCTransition
//
//  Created by Metalien on 2026/4/10.
//

import UIKit



class FirstViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置背景颜色
        view.backgroundColor = .green
        // 添加手势
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewDidTap))
        view.addGestureRecognizer(tap)
        
    }

    // 点击事件
    @objc private func viewDidTap() {
        NotificationCenter.default.post(name: NSNotification.Name(NotificationCenterJumpViewController), object: nil)
    }
}
