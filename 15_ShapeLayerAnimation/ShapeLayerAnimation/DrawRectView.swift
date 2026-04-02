//
//  DrawRectView.swift
//  ShapeLayerAnimation
//
//  Created by Metalien on 2026/4/2.
//

import UIKit

class DrawRectView: UIView {
    
    // MARK: 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 创建手势
        setupGesture()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        // 创建手势
        setupGesture()
    }
    
    /// 创建手势
    private func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(removeSelf))
        self.addGestureRecognizer(tap)
    }
    
    // MARK: Gesture
    @objc private func removeSelf() {
        self.removeFromSuperview()
    }
    
    // MARK: 绘制
    override func draw(_ rect: CGRect) {
        simpleDraw(in: rect)
        pathARC(in: rect)
        pathTriangle(in: rect)
        pathSecondBezier(in: rect)
    }
    
    // 圆角矩形 (动态适配版)
    private func simpleDraw(in rect: CGRect) {
        // 相对坐标示例：宽度为总宽的 1/3，高度自适应
        let w = rect.width * 0.3
        let h = w
        let path = UIBezierPath(roundedRect: CGRect(x: 20, y: 20, width: w, height: h), cornerRadius: 20)
        path.lineWidth = 5
        
        UIColor.green.set()
        path.fill()
        
        UIColor.red.set()
        path.stroke()
    }
    
    // 圆弧 (动态适配版)
    private func pathARC(in rect: CGRect) {
        // 使用 CGFloat.pi 代替废弃的 M_PI
        let center = CGPoint(x: 20, y: rect.height * 0.3)
        let radius = rect.width * 0.25
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat.pi / 2, clockwise: true)
        
        path.lineCapStyle = .round
        path.lineJoinStyle = .round
        path.lineWidth = 5
        
        UIColor.red.set()
        path.stroke()
    }
    
    // 三角形 (动态适配版)
    private func pathTriangle(in rect: CGRect) {
        let path = UIBezierPath()
        
        let startY = rect.height * 0.6
        let endY = rect.height * 0.8
        
        path.move(to: CGPoint(x: 20, y: startY))
        path.addLine(to: CGPoint(x: rect.width * 0.5, y: endY))
        path.addLine(to: CGPoint(x: 20, y: endY))
        path.close()
        
        path.lineWidth = 5
        
        UIColor.green.set()
        path.fill()
        
        UIColor.red.set()
        path.stroke()
    }
    
    // 贝塞尔曲线 (动态适配版)
    private func pathSecondBezier(in rect: CGRect) {
        let path = UIBezierPath()
        
        let startX = rect.width * 0.6
        let startY = rect.height * 0.3
        let endY = rect.height * 0.6
        
        path.move(to: CGPoint(x: startX, y: startY))
        // 控制点也需要动态适配
        path.addQuadCurve(to: CGPoint(x: startX, y: endY), controlPoint: CGPoint(x: startX * 0.2, y: startY * 0.3))
        path.lineWidth = 5
        
        UIColor.red.set()
        path.stroke()
    }
    
}
