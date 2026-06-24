//
//  ScanFrameView.swift
//  QRCode
//
//  Created by Metalien on 2026/6/22.
//

import UIKit

let PickingWidth: CGFloat = 300
let PickingHeight: CGFloat = 300
let PickingRect: CGRect = CGRect(x: (ScreenSizeUtils.SCREEN_WIDTH-PickingWidth)/2.0,
                                 y: (ScreenSizeUtils.SCREEN_HEIGHT-PickingHeight)/2.0,
                                 width: PickingWidth,
                                 height: PickingHeight)

class ScanFrameView: UIView {
    
    var lineLayer: CALayer!
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: ScreenSizeUtils.SCREEN_WIDTH, height: ScreenSizeUtils.SCREEN_HEIGHT))
        // 设置背景颜色
        backgroundColor = .green.withAlphaComponent(0.1)
        // 创建视图
        setupSubviews()
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 设置背景颜色
        backgroundColor = .green.withAlphaComponent(0.1)
        // 创建视图
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        let width: CGFloat = rect.size.width
        let height: CGFloat = rect.size.height
        
        let context = UIGraphicsGetCurrentContext()
        
        context!.saveGState()
        context!.setFillColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.35)
        let pickingRect = CGRect(x: (width-PickingWidth)/2, y: (height-PickingHeight)/2, width: PickingWidth, height: PickingHeight)
        
        // 贝塞尔曲线合并到一起
        let pickingPath = UIBezierPath(rect: pickingRect)
        let bezierRect = UIBezierPath(rect: rect)
        bezierRect.append(pickingPath)
        
        // 填充
        bezierRect.usesEvenOddFillRule = true
        bezierRect.fill()
        
        // 画线
        context!.setLineWidth(2)
        context!.setStrokeColor(UIColor.systemBlue.cgColor)
        pickingPath.stroke()
        
        context!.restoreGState()
        
        layer.contentsGravity = CALayerContentsGravity.center
    }
    
    // 创建视图
    private func setupSubviews() {
        
        // 初始化 CALayer
        lineLayer = CALayer()
        lineLayer.frame = CGRect(x: (ScreenSizeUtils.SCREEN_WIDTH-PickingWidth)/2.0, y: (ScreenSizeUtils.SCREEN_HEIGHT-PickingHeight)/2.0, width: PickingWidth, height: 2)
        lineLayer.contents = UIImage(named: "line")?.cgImage
        layer.addSublayer(lineLayer)
        
        // 开始动画
        startAnimation()
    }
    
    // 开始动画
    func startAnimation() {
        let basic = CABasicAnimation(keyPath: "transform.translation.y")
        basic.fromValue = 0
        basic.toValue = PickingHeight
        basic.duration = 2
        basic.repeatCount = Float(NSIntegerMax)
        lineLayer.add(basic, forKey: "translationY")
    }
    
    // 结束动画
    func stopAnimation() {
        lineLayer.removeAnimation(forKey: "translationY")
    }
    
    // MARK: - 销毁
    
    deinit {
        print("\(self.description) - 销毁了")
    }
}
