//
//  AnimationViewController.swift
//  BasicAnimation
//
//  Created by Metalien on 2026/6/2.
//

import UIKit

enum AnimationStyle {
    case none
    case position
    case opacity
    case scale
    case color
    case rotation
}

class AnimationViewController: UIViewController {
    
    var animationStyle: AnimationStyle = .none
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    let screenWidth = ScreenSizeUtils.SCREEN_WIDTH
    let screenHeight = ScreenSizeUtils.SCREEN_HEIGHT

    override func viewDidLoad() {
        super.viewDidLoad()
        // 创建视图
        setupSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 开始动画
        animationBegin()
    }
    
    // 创建视图
    private func setupSubviews() {
        // 设置属性
        imageView.center = view.center
        imageView.backgroundColor = .green
        // 添加到视图
        view.addSubview(imageView)
    }
    
    // 开始动画
    private func animationBegin() {
        switch animationStyle {
        case .position:
            positionAnimation()
        case .opacity:
            opacityAnimation()
        case .scale:
            scaleAnimation()
        case .color:
            colorAnimation()
        case .rotation:
            rotationAnimation()
        case .none:
            break
        }
    }
    
    // Position
    private func positionAnimation() {
        UIView.animate(withDuration: 0.3, animations: {
            self.imageView.center = CGPoint(x: 50, y: 50)
        }) { (_) in
            UIView.animate(withDuration: 0.3, animations: {
                self.imageView.center = CGPoint(x: 50, y: self.screenHeight-50)
            }, completion: { (_) in
                UIView.animate(withDuration: 0.3, animations: {
                    self.imageView.center = CGPoint(x: self.screenWidth-50, y: self.screenHeight-50)
                }, completion: { (_) in
                    UIView.animate(withDuration: 0.3, animations: {
                        self.imageView.center = CGPoint(x: self.screenWidth-50, y: 50)
                    }, completion: { (_) in
                        UIView.animate(withDuration: 0.3, animations: {
                            self.imageView.center = self.view.center
                        }, completion: nil)
                    })
                })
            })
        }
    }
    
    // Opacity
    private func opacityAnimation() {
        UIView.animate(withDuration: 0.5) {
            self.imageView.alpha = 0
        }
    }
    
    // Scale
    private func scaleAnimation() {
        UIView.animate(withDuration: 0.5) {
            // 这是在最初的基础上进行变化
            self.imageView.transform = CGAffineTransform(scaleX: 2, y: 2)
        }
    }
    
    // Color
    private func colorAnimation() {
        UIView.animate(withDuration: 0.5) {
            self.imageView.backgroundColor = .blue
        }
    }
    
    // Rotation
    private func rotationAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear) {
            self.imageView.transform = self.imageView.transform.rotated(by: CGFloat.pi)
        } completion: { [weak self] (_) in
            if let strongSelf = self {
                strongSelf.rotationAnimation()
            }
        }
    }
    
    // MARK: - deinit
    deinit {
        print("已销毁")
    }
    
}
