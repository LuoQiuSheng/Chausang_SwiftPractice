//
//  ViewController.swift
//  SpeechRecognition
//
//  Created by Metalien on 2026/6/25.
//

import UIKit
import Speech
import SnapKit

class ViewController: UIViewController {
    
    let speechTextView = UITextView()
    let recordButton = UIButton(type: .custom)
    let audioEngine = AVAudioEngine() // 音频
    let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "zh_Hans_CN")) // 语音识别器
    var recognitionRequest: SFSpeechAudioBufferRecognitionRequest? // 语音识别请求
    var recognitionTask: SFSpeechRecognitionTask? // 识别任务
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 检查语音识别权限
        checkSpeechRecognizer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 创建视图
        setupSubviews()
    }

    // 创建视图
    private func setupSubviews() {
        
        speechRecognizer?.delegate = self
        
        speechTextView.font = UIFont.systemFont(ofSize: 20)
        speechTextView.isUserInteractionEnabled = false
        view.addSubview(speechTextView)
        speechTextView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(ScreenSizeUtils.NAVGATION_HEIGHT)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-(50+ScreenSizeUtils.BottomSafeAreaHeight))
        }
        
        recordButton.isEnabled = false
        recordButton.setTitle("按住说话", for: .normal)
        recordButton.setTitleColor(.red, for: .highlighted)
        recordButton.setTitleColor(.black, for: .normal)
        recordButton.setTitleColor(.lightGray, for: .disabled)
        recordButton.addTarget(self, action: #selector(recordBegin), for: .touchDown)
        recordButton.addTarget(self, action: #selector(recordStop), for: .touchUpInside)
        view.addSubview(recordButton)
        recordButton.snp.makeConstraints { make in
            make.top.equalTo(speechTextView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    // 检查语音识别权限
    private func checkSpeechRecognizer() {
        SFSpeechRecognizer.requestAuthorization { status in
            OperationQueue.main.addOperation {
                switch status {
                case .authorized:
                    self.recordButton.isEnabled = true
                case .denied, .restricted, .notDetermined:
                    self.recordButton.isEnabled = false
                    self.recordButton.setTitle("开启语音识别权限", for: .disabled)
                @unknown default:
                    break
                }
            }
        }
    }
    

    // MARK: - Action
    
    // 开始录音
    @objc private func recordBegin() {
        
        // 如果任务正在执行，先取消任务
        if let task = recognitionTask {
            task.cancel()
            recognitionTask = nil
        }
        
        // 初始化音频会话
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.record)
            try audioSession.setMode(.measurement)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("音频会话配置失败：\(error.localizedDescription)")
        }
        
        // 初始化
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let request = recognitionRequest else { fatalError("创建请求失败") }
        let inputNode = audioEngine.inputNode
        // 一边解析一边反馈
        request.shouldReportPartialResults = true
        // 保持该任务的引用，方便停止
        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { result, error in
            
            var isFinal = false
            if let result = result {
                print("识别结果：\(result.transcriptions)")
                self.speechTextView.text = result.bestTranscription.formattedString
                isFinal = result.isFinal
            }
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                self.recognitionRequest = nil
                self.recognitionTask = nil
            }
            
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, when in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            print("音频引擎启动失败：\(error)")
        }
        speechTextView.text = "请开始说话 ..."
    }
    
    // 结束录音
    @objc private func recordStop() {
        if speechTextView.text == "请开始说话 ..." {
            speechTextView.text = nil
        }
        audioEngine.stop()
        recognitionRequest?.endAudio()
    }
}


extension ViewController: SFSpeechRecognizerDelegate {
    
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            print("开始识别")
        }
        else {
            print("无法识别")
        }
    }
}
