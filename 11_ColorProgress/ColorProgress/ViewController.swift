//
//  ViewController.swift
//  ColorProgress
//
//  Created by Metalien on 2026/3/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let progressView = ColorProgressView(frame: CGRectZero)
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 创建视图
        setupSubviews()
    }

    /// 创建视图
    private func setupSubviews() {
        // 设置属性
        progressView.backgroundColor = .black
        // 添加视图
        view.addSubview(progressView)
        // 设置约束
        progressView.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.left.right.equalTo(view).inset(20)
            make.height.equalTo(20)
        }
//        // 添加定时器
//        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] _ in
//            self?.progressView.progress += 0.01;
//        }
        
        // 添加定时器
        timer = Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { [weak self] _ in
            // 安全解包 self
            guard let self = self else { return }
            // 每次增加进度
            self.progressView.progress += 0.01
            // 判断：进度 >= 1.0 时，销毁定时器
            if self.progressView.progress >= 1.0 {
                // 停止并销毁定时器
                self.timer?.invalidate()
                self.timer = nil
            }
        }
    }
}


