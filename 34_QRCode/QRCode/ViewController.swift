//
//  ViewController.swift
//  QRCode
//
//  Created by Metalien on 2026/6/22.
//

import UIKit
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
    
    // MARK: - Action
    
    @objc private func buttonAction(_ sender: UIButton) {
        print("点击了：\(sender.currentTitle!)")
        
        switch sender.currentTitle! {
        case "扫描二维码":
            navigationController?.pushViewController(ScanViewController(), animated: true)
        case "图片获取":
            navigationController?.pushViewController(ImageScanViewController(), animated: true)
        default:
            break
        }
    }

}

