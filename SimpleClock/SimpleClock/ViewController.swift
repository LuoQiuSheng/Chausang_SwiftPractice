//
//  ViewController.swift
//  SimpleClock
//
//  Created by Metalien on 2026/1/8.
//

import UIKit

class ViewController: UIViewController {
    
    var width: CGFloat {
        MacroScreen.width(in: view)
    }
    var height: CGFloat {
        MacroScreen.height(in: view)
    }
    let countLabel = UILabel()
    let leftButton = UIButton(type: .custom)
    let rightButton = UIButton(type: .custom)
    var time : Timer?
    var count = 0.00
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 设置背景色
        view.backgroundColor = .white
        // 加载视图
        loadSubviews()
    }

    /// 加载视图
    private func loadSubviews() {
        // 设置尺寸
        let w = width
        let h = height
        countLabel.frame = CGRect(x: 0, y: 0, width: w, height: h / 2.0)
        leftButton.frame = CGRect(x: 0, y: h / 2.0, width: w / 2.0, height: h / 2.0)
        rightButton.frame = CGRect(x: w / 2.0, y: h / 2.0, width: w / 2.0, height: h / 2.0)
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
        [leftButton, rightButton].forEach { button in
            button.addAction(
                UIAction { [weak self] _ in
                    self?.buttonDidTapped(button)
                },
                for: .touchUpInside
            )
        }
        // 倒计时模块
        countLabel.text = "0.00"
        countLabel.textColor = .black
        countLabel.textAlignment = .center
        countLabel.font = UIFont.systemFont(ofSize: 42)
        // 添加视图
        view.addSubview(countLabel)
        view.addSubview(leftButton)
        view.addSubview(rightButton)
    }
    
    /// 点击按钮
    private func buttonDidTapped(_ sender: UIButton) {
        switch sender {
        case leftButton:
            leftButton.isSelected = !leftButton.isSelected;
            leftButton.isSelected ? startCount() : stopCount();
            break
        case rightButton:
            if leftButton.isSelected {
                rightButton.isSelected = !rightButton.isSelected;
                rightButton.isSelected ? pauseCount() : continueCount();
            }
            else {
                rightButton.isSelected = false
            }
            break
        default:
            break
        }
    }
    
    /// 开始
    private func startCount () {
        time = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { [weak self] _ in
            self?.countEvent()
        })
    }
    
    /// 结束
    private func stopCount () {
        count = 0
        countLabel.text = String(format: "%.2f", count)
        rightButton.isSelected = false
        time?.invalidate()
        time = nil
    }
    
    /// 暂停
    private func pauseCount () {
        if !leftButton.isSelected {
            return
        }
        time?.invalidate()
        time = nil
    }

    /// 继续
    private func continueCount () {
        if !leftButton.isSelected {
            return
        }
        startCount()
    }
    
    /// 计数
    private func countEvent () {
        count += 0.01
        countLabel.text = String(format: "%.2f", count)
    }
}

