//
//  ScanViewController.swift
//  QRCode
//
//  Created by Metalien on 2026/6/22.
//


import UIKit
import AVFoundation

class ScanViewController: UIViewController {
    
    var scanFrameView: ScanFrameView!
    var session: AVCaptureSession?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    private let sessionQueue = DispatchQueue(label: "com.ScanViewController.queue")
    private var isHandlingResult = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 开始扫描
        startSession()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // 结束扫描
        stopSession()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer?.frame = view.bounds
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置背景色
        view.backgroundColor = .black
        // 初始化 session
        initSession()
    }
    
    // 初始化 session
    private func initSession() {
        if session != nil { return }
        // 获取摄像头
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        
        do {
            
            let input = try AVCaptureDeviceInput(device: device) // 创建摄像头输入流
            let output = AVCaptureMetadataOutput() // 创建输出流
            
            let captureSession = AVCaptureSession()
            captureSession.beginConfiguration()
            captureSession.sessionPreset = .high
            
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
            }
            if captureSession.canAddOutput(output) {
                captureSession.addOutput(output)
            }
            
            output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            
            // 设置扫描区域
            let scanSize: CGFloat = 300
            let screenW = ScreenSizeUtils.SCREEN_WIDTH
            let screenH = ScreenSizeUtils.SCREEN_HEIGHT
            // 图像坐标系 scale 分母互换
            let scaleW = scanSize / screenH
            let scaleH = scanSize / screenW
            // 图像坐标系原点左下角，y 需要上下翻转
            let x = (1 - scaleW) / 2
            let y = (1 - scaleH) / 2
            // 图像坐标系 y 翻转修正：1 - (y + scaleH)
            let interestRect = CGRect(
                x: x,
                y: 1 - (y + scaleH),
                width: scaleW,
                height: scaleH
            )
            output.rectOfInterest = interestRect
            
            if output.availableMetadataObjectTypes.contains(.qr) {
                output.metadataObjectTypes = [.qr, .ean8, .ean13, .code128]
            }
            
            captureSession.commitConfiguration()
            // 关联对象
            session = captureSession
            // 创建视图
            setupSubviews()
            
        } catch {
            print("创建session失败：\(error.localizedDescription)")
        }
    }
    
    // 创建视图
    private func setupSubviews() {
        
        guard let session = session else { return }
        
        let layer = AVCaptureVideoPreviewLayer(session: session)
        layer.videoGravity = .resizeAspectFill
        layer.frame = view.bounds
        view.layer.insertSublayer(layer, at: 0)
        previewLayer = layer
        
        scanFrameView = ScanFrameView()
        view.addSubview(scanFrameView)
    }
    
    // 开始扫描
    private func startSession() {
        isHandlingResult = false
        
        sessionQueue.async { [weak self] in
            guard let self = self,
                  let session = self.session,
                  !session.isRunning else {
                return
            }
            
            session.startRunning()
        }
    }
    
    // 结束扫描
    private func stopSession() {
        sessionQueue.async { [weak self] in
            guard let self = self,
                  let session = self.session,
                  session.isRunning else {
                return
            }
            
            session.stopRunning()
        }
    }
}


extension ScanViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        guard !isHandlingResult else { return }
        
        guard let metadata = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
              let result = metadata.stringValue else {
            return
        }
        // 标记
        isHandlingResult = true
        // 结束扫描
        stopSession()
        // 提醒
        let alertController = UIAlertController(
            title: "扫描结果",
            message: result,
            preferredStyle: .alert
        )
        let action = UIAlertAction(title: "确定", style: .default) { [weak self] _ in
            // 开始扫描
            self?.startSession()
        }
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
}

