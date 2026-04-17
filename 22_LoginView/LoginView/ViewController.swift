//
//  ViewController.swift
//  LoginView
//
//  Created by Metalien on 2026/4/17.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let nicknameTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton(type: .custom)
    // 标记：是否已经上移，防止重复动画
    private var isViewMoved: Bool = false
    
    
    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置属性
        view.backgroundColor = .white
        // 创建视图
        setupSubviews()
        // 创建通知中心
        setupNotificationCenter()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - Private
    
    // 创建视图
    private func setupSubviews() {
        // 自定义
        nicknameTextField.setupTextField(placeholer: "请输入手机号码", keyboardType: .numberPad, text: nil)
        passwordTextField.setupTextField(placeholer: "请输入密码", keyboardType: .asciiCapable, text: nil)
        passwordTextField.isSecureTextEntry = true
        loginButton.setupButton(title: "登录", bgColor: .blue)
        loginButton.addTarget(self, action: #selector(loginButtonAction(sender:)), for: .touchUpInside)
        // 添加视图
        view.addSubview(nicknameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        // 设置约束
        nicknameTextField.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(30)
        }
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(10)
            make.leading.trailing.equalTo(nicknameTextField)
            make.height.equalTo(nicknameTextField)
        }
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.leading.trailing.equalTo(nicknameTextField)
            make.height.equalTo(40)
        }
    }
    
    // 创建通知中心
    private func setupNotificationCenter() {
        // 监听键盘弹出
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        // 监听键盘收起
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    // MARK: - NotificationCenter Event
    
    // 键盘弹出
    @objc func keyboardWillShow(notification: Notification) {
        guard let info = notification.userInfo, !isViewMoved else { return }
        if let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height
            let duration = info[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0.25
            // 标记已上移，防止重复触发
            isViewMoved = true
            // 推荐用 transform，不破坏原始 frame，绝对不抖动
            UIView.animate(withDuration: duration) {
                self.view.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight/2)
            }
        }
    }

    // 键盘收起
    @objc func keyboardWillHide(notification: Notification) {
        guard let info = notification.userInfo, isViewMoved else { return }
        let duration = info[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0.25
        // 标记已复位
        isViewMoved = false
        // 复位（最安全、最稳定）
        UIView.animate(withDuration: duration) {
            self.view.transform = .identity
        }
    }
    
    // MARK: - Action
    
    // 登录
    @objc func loginButtonAction(sender: UIButton) {
        if nicknameTextField.isFirstResponder {
            nicknameTextField.resignFirstResponder()
        }
        if passwordTextField.isFirstResponder {
            passwordTextField.resignFirstResponder()
        }
    }
    
    
    // MARK: - Deinit
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

//    // 键盘弹出
//    @objc func keyboardWillShow(notification: Notification) {
//        guard let info = notification.userInfo else { return }
//        // 获取键盘高度
//        if let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
//            let keyboardHeight = keyboardFrame.height
//            DLog("键盘高度：\(keyboardHeight)")
//            if keyboardHeight/2 == -view.frame.origin.y {
//                DLog("无需再次移动！")
//                return
//            }
//            // 键盘动画时长
//            let duration = info[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0.25
//            // 动画效果
//            UIView.animate(withDuration: duration) {
//                self.view.frame = CGRect(x: 0,
//                                         y: -keyboardHeight/2,
//                                         width: ScreenSizeUtils.SCREEN_WIDTH,
//                                         height:ScreenSizeUtils.SCREEN_HEIGHT)
//            }
//        }
//    }

//    // 键盘收起
//    @objc func keyboardWillHide(notification: Notification) {
//        guard let info = notification.userInfo else { return }
//        if view.frame.origin.x == 0 {
//            DLog("无需再次复位！")
//        }
//        // 键盘动画时长
//        let duration = info[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0.25
//        // 动画效果
//        UIView.animate(withDuration: duration) {
//            self.view.frame = ScreenSizeUtils.SCREEN_RECT
//        }
//    }
