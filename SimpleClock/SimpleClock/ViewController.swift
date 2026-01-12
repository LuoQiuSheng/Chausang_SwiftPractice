//
//  ViewController.swift
//  SimpleClock
//
//  Created by Metalien on 2026/1/8.
//

import UIKit

class ViewController: UIViewController {
    
    
    let countLabel = UILabel(frame: CGRectMake(0, 0, MacroScreen.width, MacroScreen.height/2.0))
    let leftButton = UIButton(frame: CGRectMake(0, MacroScreen.height/2.0, MacroScreen.width/2.0, MacroScreen.height/2.0))
    let rightButton = UIButton(frame: CGRectMake(MacroScreen.width/2.0, MacroScreen.height/2.0, MacroScreen.width/2.0, MacroScreen.height/2.0))
    var time : Timer?
    var count = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 设置背景色
        view.backgroundColor = .white
        // 加载视图
        loadSubviews()
    }

    /// 加载视图
    func loadSubviews() {
        // 设置背景色
        countLabel.backgroundColor = .yellow
        leftButton.backgroundColor = .blue
        rightButton.backgroundColor = .red
        // 设置按钮标题
        leftButton.setTitle("开始", for: .normal)
        leftButton.setTitle("结束", for: .selected)
        rightButton.setTitle("暂停", for: .normal)
        rightButton.setTitle("继续", for: .selected)
        // 添加点击动作
//        [leftButton, rightButton].forEach {
//            ($0.addTarget(self, action: #selector(buttonDidTapped(sender:)), for: .touchUpInside))
//        }
        [leftButton, rightButton].forEach { button in
            
//            button.addAction(UIAction { [weak self] _ in
//                self?.buttonDidTapped(button)
//            }, for: .touchUpInside)
            
            button.addAction(.buttonDidTapped(button), for: .touchUpInside)
        }

    }
    
    /// 点击按钮
    private func buttonDidTapped(_ sender: UIButton) {
        
    }

}

