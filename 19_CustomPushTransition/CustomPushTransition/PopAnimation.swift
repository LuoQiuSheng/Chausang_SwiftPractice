//
//  PopAnimation.swift
//  CustomPushTransition
//
//  Created by Metalien on 2026/4/14.
//

import UIKit

class PopAnimation: NSObject, UIViewControllerAnimatedTransitioning, CAAnimationDelegate {

    var transitionContext: UIViewControllerContextTransitioning?
    
    // 转场时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2
    }
    
    // 转场动画
    func animateTransition(using transitionContext: any UIViewControllerContextTransitioning) {
        // 该参数包含了控制转场动画必要的信息
        self.transitionContext = transitionContext
        // 目标VC
        let toVC = transitionContext.viewController(forKey: .to)
        // 当前VC
        let fromVC = transitionContext.viewController(forKey: .from)
        // 容器View，转场动画都是在该容器中进行的，导航控制的wrapper view就是改容器
        let containerView = transitionContext.containerView
        containerView.addSubview((toVC?.view)!)
        containerView.addSubview((fromVC?.view)!)
        
        let starPath = UIBezierPath(rect: CGRect(x: 0, y: ScreenSizeUtils.SCREEN_HEIGHT*0.5-2, width: ScreenSizeUtils.SCREEN_WIDTH, height: 4))
        let finalPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: ScreenSizeUtils.SCREEN_WIDTH, height: ScreenSizeUtils.SCREEN_HEIGHT))
        let maskLayer = CAShapeLayer()
        maskLayer.path = finalPath.cgPath
        
        fromVC?.view.layer.mask = maskLayer
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = finalPath.cgPath
        animation.toValue = starPath.cgPath
        animation.duration = transitionDuration(using: transitionContext)
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.delegate = self
        maskLayer.add(animation, forKey: "path")
    }
    
    // 动画结束
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        // 通知transition完成,该方法一定要调用
        transitionContext?.completeTransition(!(transitionContext?.transitionWasCancelled)!)
        // 清除fromVC的mask
        transitionContext?.viewController(forKey: .from)?.view.layer.mask = nil
        transitionContext?.viewController(forKey: .to)?.view.layer.mask = nil
    }
}
