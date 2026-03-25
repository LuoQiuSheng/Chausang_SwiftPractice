//
//  ViewController.swift
//  VideoBackground
//
//  Created by Metalien on 2026/3/25.
//

import UIKit
import AVKit
import SnapKit

class ViewController: UIViewController {
    
    let playerVC = AVPlayerViewController()
    let loginButton = UIButton()
    let registerButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        // 创建视图
        setupSubviews()
    }

    /// 创建视图
    private func setupSubviews() {
        // 获取视频资源
        guard let videoPath = Bundle.main.path(forResource: "moments", ofType: "mp4") else {
            print("视频文件不存在")
            return
        }
        let videoURL = URL(fileURLWithPath: videoPath)
        
        // 初始化播放器
        playerVC.player = AVPlayer(url: videoURL)
        playerVC.showsPlaybackControls = false
        playerVC.videoGravity = .resizeAspectFill
        playerVC.view.alpha = 0
        
        // 按钮
        loginButton.customWhiteLayerButton(title: "登录")
        loginButton.addTarget(self, action: #selector(loginButtonAction(sender:)), for: .touchUpInside)
        registerButton.customWhiteLayerButton(title: "注册")
        registerButton.addTarget(self, action: #selector(registerButtonAction(sender:)), for: .touchUpInside)
        
        // 添加视图
        view.addSubview(playerVC.view)
        view.addSubview(registerButton)
        view.addSubview(loginButton)
        
        // 设置约束
        playerVC.view.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        registerButton.snp.makeConstraints { make in
            make.left.right.equalTo(view).inset(30)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-40)
            make.height.equalTo(50)
        }
        loginButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(registerButton)
            make.height.equalTo(registerButton)
            make.bottom.equalTo(registerButton.snp.top).offset(-12)
        }
        
        // 动画效果
        UIView.animate(withDuration: 1.0) {
            self.playerVC.view.alpha = 1.0
        } completion: { _ in
            self.playerVC.player?.play()
            // 循环播放
            self.addLoopObserver()
        }
    }
    
    /// 循环播放
    private func addLoopObserver() {
        // 获取当前播放器
        guard let player = playerVC.player else { return }
        // 监听【播放结束】通知
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(playVideoAgain), // 结束后调用这个方法
            name: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem
        )
    }
    
    
    // MARK: Action
    
    /// 重新播放
    @objc private func playVideoAgain() {
        // 把播放进度退回开头
        playerVC.player?.seek(to: .zero)
        // 再次播放
        playerVC.player?.play()
    }
    
    @objc private func loginButtonAction(sender: UIButton) {
        print("登录")
    }
    
    @objc private func registerButtonAction(sender: UIButton) {
        print("注册")
    }
    
    
    // MARK: Deinit
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

