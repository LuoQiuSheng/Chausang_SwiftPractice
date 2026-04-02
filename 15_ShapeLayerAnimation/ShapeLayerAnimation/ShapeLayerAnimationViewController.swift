//
//  ShapeLayerAnimationViewController.swift
//  ShapeLayerAnimation
//
//  Created by Metalien on 2026/4/2.
//

import UIKit

class ShapeLayerAnimationViewController: UIViewController {
    
    private let shapeLayer = CAShapeLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置属性
        title = "Shape Layer 动画"
        view.backgroundColor = .white
        // 创建视图
        setupSubviews()
    }
    

    /// 创建视图
    private func setupSubviews() {
        
        let centerX: Double = 200.0
        let centerY: Double = 300.0
        
        // 贝塞尔曲线
        let path = UIBezierPath(arcCenter: CGPoint(x: centerX, y: centerY), radius: 80, startAngle: 0, endAngle: CGFloat.pi*2.0, clockwise: false)
        
        // 创建动画
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.duration = 3.0
        animation.delegate = self
        
        // 初始化
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.green.cgColor
        shapeLayer.lineWidth = 8.0
        shapeLayer.lineCap = .round
        shapeLayer.lineJoin = .round
        shapeLayer.autoreverses = false
        shapeLayer.path = path.cgPath
        shapeLayer.add(animation, forKey: nil)
        view.layer.addSublayer(shapeLayer)
        
        // 线条
        let count: NSInteger = 21
        for i in 0..<count {
            
            let len = 50
            
            let x_1 = centerX + 100 * cos(2.0*Double(i)*CGFloat.pi/Double(count))
            let y_1 = centerY - 100 * sin(2.0*Double(i)*CGFloat.pi/Double(count))
            
            let x_2 = x_1 + Double(len)*cos(2*CGFloat.pi/Double(count)*Double(i))
            let y_2 = y_1 - Double(len)*sin(2*CGFloat.pi/Double(count)*Double(i))
            
            let tempPath = UIBezierPath()
            tempPath.move(to: CGPoint(x: x_1, y: y_1))
            tempPath.addLine(to: CGPoint(x: x_2, y: y_2))
            
            let line = CAShapeLayer()
            line.fillColor = UIColor.clear.cgColor
            line.strokeColor = UIColor.green.cgColor
            line.lineWidth = 5.0
            line.lineCap = .round
            line.lineJoin = .round
            line.path = tempPath.cgPath
            line.add(animation, forKey: nil)
            view.layer.addSublayer(line)
        }
    }
    

}

extension ShapeLayerAnimationViewController: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        shapeLayer.fillColor = UIColor.green.cgColor
    }
    
}
