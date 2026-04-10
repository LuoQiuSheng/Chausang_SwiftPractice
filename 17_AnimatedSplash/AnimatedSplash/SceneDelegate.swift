//
//  SceneDelegate.swift
//  AnimatedSplash
//
//  Created by Metalien on 2026/4/10.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let maskLayer = CALayer()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        maskLayer.contents = UIImage(named: "twitter")?.cgImage
        maskLayer.contentsGravity = .resizeAspect
        maskLayer.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        maskLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        maskLayer.position = CGPoint(x: ScreenSizeUtils.SCREEN_WIDTH/2.0, y: ScreenSizeUtils.SCREEN_HEIGHT/2.0)
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = ViewController()
        window.rootViewController?.view.layer.mask = maskLayer
        window.backgroundColor = .green
        
        // 动画效果
        animationMaskLayer()
        
        window.makeKeyAndVisible()
        
        self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    // 动画效果
    private func animationMaskLayer() {
        /*
         keyframe与basic区别：
         1.basic只能从一个数值到另一个数值
         2.keyframe使用一个nsarray保存这些值
         3.basic可以看做只有2个关键帧的keyframe关键帧动画
         */
        
        let firstBounds = NSValue(cgRect: maskLayer.bounds)
        let secondBounds = NSValue(cgRect: CGRect(x: 0, y: 0, width: 300, height: 300))
        let finalBounds = NSValue(cgRect: CGRect(x: 0, y: 0, width: 1100, height: 1100))
        
        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "bounds")
        keyFrameAnimation.delegate = self
        keyFrameAnimation.duration = 0.6
        keyFrameAnimation.beginTime = CACurrentMediaTime() + 0.5
        keyFrameAnimation.timingFunctions = [CAMediaTimingFunction(name: .easeOut), CAMediaTimingFunction(name: .easeOut), CAMediaTimingFunction(name: .easeOut)]
        keyFrameAnimation.values = [firstBounds, secondBounds, finalBounds]
        keyFrameAnimation.keyTimes = [0, 0.5, 1]
        maskLayer.add(keyFrameAnimation, forKey: "bounds")
    }
    
}

extension SceneDelegate: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        window?.rootViewController?.view.layer.mask = nil
    }
}

