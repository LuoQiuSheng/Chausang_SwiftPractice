//
//  HUDManager.swift
//  NetPictures
//
//  Created by Metalien on 2026/6/26.
//

import UIKit
//import ProgressHUD
//
//final class HUDManager {
//    static let shared = HUDManager()
//    private init() {
//        // 全局统一配置 ProgressHUD
//        setupProgressHUD()
//    }
//    
//    // 全局统一配置 ProgressHUD
//    private func setupProgressHUD() {
//        // 加载动画样式
//        ProgressHUD.animationType = .circleRotateChase
//        // HUD弹窗背景色
//        ProgressHUD.colorHUD = .lightGray.withAlphaComponent(0.3)
//        // 全屏遮罩背景
//        ProgressHUD.colorBackground = .black.withAlphaComponent(0.1)
//        // 菊花/动画颜色
//        ProgressHUD.colorAnimation = .gray
//        // 文字颜色
//        ProgressHUD.colorStatus = .gray
//        // 文字字体
//        ProgressHUD.fontStatus = UIFont.systemFont(ofSize: 18)
//        // 弹窗尺寸边距
//        ProgressHUD.mediaSize = 60
//        ProgressHUD.marginSize = 24
//        
//        // 成功/失败自定义图片（可选）
//        // ProgressHUD.imageSuccess = UIImage(named: "success")
//        // ProgressHUD.imageError = UIImage(named: "fail")
//        
//        // Banner customization:
//        ProgressHUD.colorBanner = .blue.withAlphaComponent(0.1)
//        ProgressHUD.colorBannerTitle = .gray
//        ProgressHUD.colorBannerMessage = .gray
//        ProgressHUD.fontBannerTitle = UIFont.systemFont(ofSize: 16, weight: .semibold)
//        ProgressHUD.fontBannerMessage = UIFont.systemFont(ofSize: 14)
//        
//    }
//    
//    // MARK: 加载等待
//    func showLoading(_ msg: String?, interaction: Bool = false) {
//        DispatchQueue.main.async {
//            if let text = msg, !text.isEmpty {
//                ProgressHUD.animate(text, interaction: interaction)
//            } else {
//                ProgressHUD.animate(interaction: interaction)
//            }
//        }
//    }
//    
//    func dismissLoading() {
//        DispatchQueue.main.async {
//            ProgressHUD.dismiss()
//        }
//    }
//    
//    // MARK: 纯文本提示
//    func showText(_ msg: String, delay: TimeInterval = 2.0) {
//        DispatchQueue.main.async {
//            ProgressHUD.succeed(msg, delay: delay)
////            ProgressHUD.animate(msg, .none, interaction: true)
////            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
////                self.dismissLoading()
////            }
//        }
//    }
//    
//    // MARK: 成功提示
//    func showSuccess(_ msg: String, delay: TimeInterval = 2.0) {
//        DispatchQueue.main.async {
//            ProgressHUD.succeed(msg, delay: delay)
//        }
//    }
//    
//    // MARK: 错误提示
//    func showError(_ msg: String, delay: TimeInterval = 2.0) {
//        DispatchQueue.main.async {
//            ProgressHUD.failed(msg, delay: delay)
//        }
//    }
//    
//    // MARK: Banner顶部提示
//    func showBanner(title: String = "", message: String, delay: TimeInterval = 2.0) {
//        DispatchQueue.main.async {
//            ProgressHUD.banner(title, message, delay: delay)
//        }
//    }
//    
//    // MARK: 清空接口
//    /// 仅清空Banner
//    func clearAllBanner() {
//        DispatchQueue.main.async {
//            ProgressHUD.bannerHide()
//        }
//    }
//    
//    /// 清空中间弹窗（loading/text/success/error）
//    func clearNormalHUD() {
//        DispatchQueue.main.async {
//            ProgressHUD.dismiss()
//        }
//    }
//    
//    /// 清空全部弹窗
//    func clearAll() {
//        DispatchQueue.main.async {
//            ProgressHUD.remove()
//        }
//    }
//}
