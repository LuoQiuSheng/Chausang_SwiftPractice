//
//  ViewController.swift
//  WaveView
//
//  Created by Metalien on 2026/3/27.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let waveView = WaveView(frame: CGRectMake(0, 200, ScreenSizeUtils.SCREEN_WIDTH, 31))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 创建视图
        setupSubviews()
    }

    /// 创建视图
    private func setupSubviews() {
        
        
        // 初始化
        waveView.waveSpeed = 10
        waveView.waveAngularSpeed = 1.5
        // 添加视图
        view.addSubview(waveView)
        
        
        let whiteView = UIView(frame: CGRect(x: 0.0, y: 230, width: ScreenSizeUtils.SCREEN_WIDTH, height: ScreenSizeUtils.SCREEN_HEIGHT-230))
        whiteView.backgroundColor = .white
        view.addSubview(whiteView)
        
        let btn = UIButton(frame: CGRect(x: 100, y: 400, width: ScreenSizeUtils.SCREEN_WIDTH-200, height: 30))
        btn.setTitle("开始", for: .normal)
        btn.setTitle("结束", for: .selected)
        btn.setTitleColor(.orange, for: .normal)
        view.addSubview(btn)
        btn.addTarget(self, action: #selector(changeStatus(sender:)), for: .touchUpInside)
        
//        // 设置约束
//        waveView.snp.makeConstraints { make in
//            make.top.left.right.equalTo(view)
//            make.height.equalTo(230)
//        }
        
//        // 开始动画
//        waveView.startWaveAnimation()
        
    }
    
    // MARK: Action
    
    @objc private func changeStatus(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        sender.isSelected ? waveView.startWaveAnimation() : waveView.stopWaveAnimation()
    }
    
}

