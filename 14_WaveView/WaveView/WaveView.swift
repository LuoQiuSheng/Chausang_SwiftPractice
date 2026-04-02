//
//  WaveView.swift
//  WaveView
//
//  Created by Metalien on 2026/3/27.
//

import UIKit

class WaveView: UIView {
    
    var waveSpeed: CGFloat = 1.8 // 速度
    var waveAngularSpeed: CGFloat = 2.0 // 周期
    var waveColor: UIColor = .white // 颜色
//    var waveAmplitude: CGFloat = 10.0 // 新增：控制波浪起伏幅度
    
    private var waveDisplayLink: CADisplayLink?
    private var waveShapeLayer: CAShapeLayer?
    private var offsetX: CGFloat = 0.0
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 确保在视图移除时停止，解决循环引用
    override func removeFromSuperview() {
        super.removeFromSuperview()
        waveDisplayLink?.invalidate()
        waveDisplayLink = nil
    }
    
    /// 开始波浪动画
    func startWaveAnimation() {
        if waveShapeLayer != nil { return }
        
        waveShapeLayer = CAShapeLayer()
        waveShapeLayer?.fillColor = waveColor.cgColor
        layer.addSublayer(waveShapeLayer!)
        
        // 关键修复：使用 weak target 或确保能被销毁
        // 简单做法：直接用 displayLink
        waveDisplayLink = CADisplayLink(target: self, selector: #selector(updateWaveFrame))
        waveDisplayLink?.add(to: .main, forMode: .common)
    }
    
    /// 结束波浪动画
    func stopWaveAnimation() {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
        }) { (finished) in
            self.waveDisplayLink?.invalidate()
            self.waveDisplayLink = nil
            self.waveShapeLayer?.removeFromSuperlayer()
            self.waveShapeLayer = nil
            self.alpha = 1
        }
    }
    
    /// 更新波浪
    @objc func updateWaveFrame() {
        offsetX -= waveSpeed
        
        let width = frame.size.width
        let height = frame.size.height
        // 创建path
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: height/2))
        var y: CGFloat = 0.0
        for x in stride(from: 0, through: width, by: 1) {
            y = height * sin(0.01 * (waveAngularSpeed * x + offsetX))
            path.addLine(to: CGPoint(x: x, y: y))
        }
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.closeSubpath()
        
        waveShapeLayer?.path = path
    }
    
    //    /// 销毁
    //    deinit {
    //        stopWaveAnimation()
    //    }
    
}
