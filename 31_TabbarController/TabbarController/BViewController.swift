//
//  BViewController.swift
//  TabbarController
//
//  Created by Metalien on 2026/6/8.
//

import UIKit
import SnapKit

class BViewController: UIViewController {
    
    let backgroundImageView = UIImageView(image: UIImage(named: "Explore"))
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 弹出效果
        showAnimationImageView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 默认样式
        setDefaultImageViewStyle()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // 创建视图
        setupSubviews()
    }
    
    // 创建视图
    private func setupSubviews() {
        // 设置属性
        backgroundImageView.contentMode = .scaleAspectFit
        // 添加视图
        view.addSubview(backgroundImageView)
        // 设置约束
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        // 默认样式
        setDefaultImageViewStyle()
    }

    // 默认样式
    private func setDefaultImageViewStyle() {
        backgroundImageView.alpha = 0
        backgroundImageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
    }
    
    // 弹出效果
    private func showAnimationImageView() {
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseIn,
                       animations: {
            self.backgroundImageView.alpha = 1
            self.backgroundImageView.transform = .identity
        }, completion: nil)
    }
}
