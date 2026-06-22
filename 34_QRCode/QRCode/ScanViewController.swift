//
//  ScanViewController.swift
//  QRCode
//
//  Created by Metalien on 2026/6/22.
//

import UIKit
import AVFoundation

class ScanViewController: UIViewController {
    
    var session: AVCaptureSession?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        session?.startRunning()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        session?.stopRunning()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 创建视图
        setupSubviews()
    }

    // 创建视图
    private func setupSubviews() {
        
    }
    
}
