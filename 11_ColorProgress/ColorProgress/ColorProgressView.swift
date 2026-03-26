//
//  ColorProgressView.swift
//  ColorProgress
//
//  Created by Metalien on 2026/3/26.
//

import UIKit

class ColorProgressView: UIView {

    let gradientLayer = CAGradientLayer()
    let backgroundMaskLayer = CALayer()
    let maskLayer = CALayer()
    var progress: CGFloat = 0.0 {
        didSet {
            // 更新遮罩层
            updateMaskFrame()
        }
    }
    
    /// 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 创建视图
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 当完成布局后，同步 Layer 的尺寸
        let radius = bounds.size.height / 2.0
        backgroundMaskLayer.frame = bounds
        backgroundMaskLayer.cornerRadius = radius
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = radius
        maskLayer.cornerRadius = radius
        updateMaskFrame()
    }
    
    /// 创建视图
    private func setupSubviews() {
        
        // 背景层配置
        backgroundMaskLayer.borderColor = UIColor.white.cgColor
        backgroundMaskLayer.borderWidth = 1.0
        
        // 遮罩层配置
        maskLayer.backgroundColor = UIColor.white.cgColor
        
        // 渐变层配置
        var colors = [CGColor]()
        for hue in stride(from: 0, through: 360, by: 5) {
            let color = UIColor(hue: CGFloat(hue)/360.0, saturation: 1.0, brightness: 1.0, alpha: 1).cgColor
            colors.append(color)
        }
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.borderColor = UIColor.white.cgColor
        gradientLayer.borderWidth = 1.0
        gradientLayer.mask = maskLayer
        
        // 添加视图
        layer.addSublayer(backgroundMaskLayer)
        layer.addSublayer(gradientLayer)
        
        // 动画效果
        performAnimation()
    }
    
    /// 更新遮罩层
    private func updateMaskFrame() {
        // 确保在 layoutSubviews 调用之后或 progress 改变时，mask 能对齐
        maskLayer.frame = CGRect(x: 0.0, y: 0.0, width: progress * bounds.size.width, height: bounds.size.height)
    }
    
    /// 动画效果
    private func performAnimation() {
        
        var colors = gradientLayer.colors
        guard let color = colors?.popLast() else { return }
        colors?.insert(color, at: 0)
        
        let animation = CABasicAnimation(keyPath: "colors")
        animation.fromValue = gradientLayer.colors
        animation.toValue = colors
        animation.duration = 0.08
        animation.fillMode = .forwards
        animation.delegate = self
        gradientLayer.add(animation, forKey: "gradient")
        gradientLayer.colors = colors
    }
    
}


extension ColorProgressView: CAAnimationDelegate {
    
    // 动画停止后继续动画
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        performAnimation()
    }
}
