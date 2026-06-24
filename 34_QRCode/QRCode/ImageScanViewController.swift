//
//  ImageScanViewController.swift
//  QRCode
//
//  Created by Metalien on 2026/6/22.
//

import UIKit
import SnapKit

class ImageScanViewController: UIViewController {
    
    var qrCodeImageView: UIImageView!
    // CIDetector：iOS自带的识别图片的类
    private lazy var qrDetector: CIDetector? = {
        CIDetector(
            ofType: CIDetectorTypeQRCode,
            context: nil,
            options: [CIDetectorAccuracy: CIDetectorAccuracyHigh]
        )
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置背景颜色
        view.backgroundColor = .white
        // 创建视图
        setupSubviews()
    }
    
    // 创建视图
    private func setupSubviews() {
        
        // 创建 UIImageView
        qrCodeImageView = UIImageView(image: UIImage(named: "pic"))
        qrCodeImageView.contentMode = .scaleAspectFit
        qrCodeImageView.isUserInteractionEnabled = true
        view.addSubview(qrCodeImageView)
        qrCodeImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 300, height: 300))
        }
        
        // 添加手势
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(qrCodeImageViewPress(gesture:)))
        qrCodeImageView.addGestureRecognizer(longPress)
        
        // 创建 Label
        let tipLabel = UILabel()
        tipLabel.font = UIFont.systemFont(ofSize: 14)
        tipLabel.text = "长按图片识别"
        tipLabel.textColor = .black
        tipLabel.textAlignment = .center
        view.addSubview(tipLabel)
        tipLabel.snp.makeConstraints { make in
            make.top.equalTo((qrCodeImageView.snp.bottom)).offset(12)
            make.left.right.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    // 弹出识别视图
    private func showCIDetectorView() {
        guard let image = qrCodeImageView.image,
              let ciImage = CIImage(image: image) else {
            showAlert(message: "图片不存在或无法识别")
            return
        }
        guard let detector = qrDetector else {
            showAlert(message: "识别器创建失败")
            return
        }
        
        let features = detector.features(in: ciImage)
        guard let qrCodeFeature = features.first as? CIQRCodeFeature,
              let result = qrCodeFeature.messageString,
              !result.isEmpty else {
            showAlert(message: "未扫描到结果")
            return
        }
        // 弹出警告
        showAlert(message: result)
    }
    
    // 弹出警告
    private func showAlert(message: String) {
        let alertController = UIAlertController(
            title: "扫描结果",
            message: message,
            preferredStyle: .alert
        )
        alertController.addAction(UIAlertAction(title: "确定", style: .default))
        present(alertController, animated: true)
    }

    // MARK: - Gesture
    
    @objc private func qrCodeImageViewPress(gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            // 弹出识别视图
            showCIDetectorView()
        default:
            break
        }
    }
    
    // MARK: - Deinit
    
    deinit {
        print("\(self.description) - 已销毁")
    }
    
}
