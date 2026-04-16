//
//  MenuViewController.swift
//  TumblrMenu
//
//  Created by Metalien on 2026/4/16.
//

import UIKit
import SnapKit

class MenuViewController: UIViewController {
    
    var btns = [UIButton]()
//    let transitionManager = MenuTransitionManger()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 设置属性
        view.backgroundColor = UIColor(white: 1, alpha: 0.3)
        // 创建视图
        setupSubviews()
    }
    
    // 创建视图
    private func setupSubviews() {
//        // 创建动画
//        transitioningDelegate = transitionManager
        // 配置
        let margin: CGFloat = 15        // 左右边距
        let spacing: CGFloat = 0       // 按钮之间间距
        let btnWidth = (ScreenSizeUtils.SCREEN_WIDTH - margin * 2 - spacing) / 2
        let btnHeight: CGFloat = (ScreenSizeUtils.SCREEN_HEIGHT - ScreenSizeUtils.STATUSBAR_HEIGHT)/3.0     // 按钮高度
        let rowHeight = btnHeight + 20  // 行高
        let imageNames = ["Audio", "Chat", "Link", "Photo", "Quote", "Text"]
        //
        for index in 0..<imageNames.count {
            // 计算位置
            let row = index / 2    // 第几行
            let col = index % 2    // 第几列（0左 1右）
            let x = margin + (btnWidth + spacing) * CGFloat(col)
            let y = 20 + rowHeight * CGFloat(row)
            // 初始化
            let tempButton = UIButton(type: .custom)
            tempButton.frame = CGRect(x: x, y: y, width: btnWidth, height: btnHeight)
            tempButton.setTitle(imageNames[index], for: .normal)
            tempButton.setTitleColor(.white, for: .normal)
            tempButton.setImage(UIImage(named: imageNames[index]), for: .normal)
            tempButton.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)
            tempButton.alignContentVerticallyByCenter()
            view.addSubview(tempButton)
            btns.append(tempButton)
        }
    }
    
    // MARK: - Action
    
    @objc private func menuButtonAction(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
