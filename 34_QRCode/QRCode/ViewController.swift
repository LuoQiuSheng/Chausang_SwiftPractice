//
//  ViewController.swift
//  QRCode
//
//  Created by Metalien on 2026/6/22.
//

import UIKit
import AVFoundation
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置标题
        title = "选择方式"
        // 创建视图
        setupSubviews()
    }

    // 创建视图
    private func setupSubviews() {
        
        // 扫码
        let scanButton = UIButton(type: .custom)
        scanButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        scanButton.setTitle("扫描二维码", for: .normal)
        scanButton.setTitleColor(.black, for: .normal)
        scanButton.addTarget(self, action: #selector(buttonAction(_ :)), for: .touchUpInside)
        view.addSubview(scanButton)
        scanButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(180)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(45)
        }
        
        // 图片扫码
        let imageScanButton = UIButton(type: .custom)
        imageScanButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        imageScanButton.setTitle("图片获取", for: .normal)
        imageScanButton.setTitleColor(.black, for: .normal)
        imageScanButton.addTarget(self, action: #selector(buttonAction(_ :)), for: .touchUpInside)
        view.addSubview(imageScanButton)
        imageScanButton.snp.makeConstraints { make in
            make.top.equalTo(scanButton.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(30)
        }
        
    }
    
    // 检查相机权限
    private func checkCameraPermisson() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .restricted, .denied:
            // 弹出相机权限设置提示
            showNoCameraPermissionAlert()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { (isAllow) in
                if isAllow {
                    // 跳转到扫描页面
                    self.pustToScanViewController()
                }
                else {
                    // 弹出相机权限设置提示
                    self.showNoCameraPermissionAlert()
                }
            }
        default:
            // 跳转到扫描页面
            pustToScanViewController()
        }
    }
    
    // 弹出相机权限设置提示
    private func showNoCameraPermissionAlert() {
        let alert = UIAlertController(title: "相机权限未开启", message: "前往设置开启相机权限才能扫码", preferredStyle: .alert)
        alert.addAction(.init(title: "取消", style: .cancel))
        alert.addAction(.init(title: "去设置", style: .default, handler: { _ in
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            UIApplication.shared.open(url)
        }))
        present(alert, animated: true)
    }
    
    // 跳转到扫描页面
    private func pustToScanViewController() {
        navigationController?.pushViewController(ScanViewController(), animated: true)
    }
    
    // MARK: - Action
    
    @objc private func buttonAction(_ sender: UIButton) {
        switch sender.currentTitle! {
        case "扫描二维码":
            // 检查相机权限
            checkCameraPermisson()
        case "图片获取":
            navigationController?.pushViewController(ImageScanViewController(), animated: true)
        default:
            break
        }
    }

}

