//
//  ViewController.swift
//  GradientColor
//
//  Created by Metalien on 2026/3/24.
//

import UIKit

class ViewController: UIViewController {
    
    let gradientLayer = CAGradientLayer()
    // 定义定时器
    var colorTimer: Timer?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 设置背景色
        view.backgroundColor = .white
        // 创建视图
        setupSubviews()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // 销毁定时器
        colorTimer?.invalidate()
        colorTimer = nil
    }


    /// 创建视图
    private func setupSubviews() {
        
        // 素材
        let color1 = UIColor(white: 0.5, alpha: 0.2).cgColor
        let color2 = UIColor(red: 1.0, green: 0, blue: 0, alpha: 0.4).cgColor
        let color3 = UIColor(red: 0, green: 1, blue: 0, alpha: 0.3).cgColor
        let color4 = UIColor(red: 0, green: 0, blue: 1, alpha: 0.3).cgColor
        let color5 = UIColor(white: 0.4, alpha: 0.2).cgColor
        // 初始化
        gradientLayer.frame = CGRect(x: 0, y: 0, width: ScreenSizeUtils.SCREEN_WIDTH, height: ScreenSizeUtils.SCREEN_HEIGHT)
        gradientLayer.colors = [color1, color2, color3, color4, color5]
        gradientLayer.locations = [0.10, 0.30, 0.50, 0.70, 0.90]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        view.layer.addSublayer(gradientLayer)
        // 添加定时器
        colorTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.randomColor()
        }
//        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(randomColor), userInfo: nil, repeats: true)
    }
    
    
    // MARK: Action
    
    @objc func randomColor() {
        view.backgroundColor = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
    }
}

