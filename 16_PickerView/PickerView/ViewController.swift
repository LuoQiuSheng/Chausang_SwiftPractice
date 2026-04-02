//
//  ViewController.swift
//  PickerView
//
//  Created by Metalien on 2026/4/2.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private let pickerView = UIPickerView()
    private let dateLabel = UILabel()
    private let randomButton = UIButton(type: .custom)
    
    private let hours = 0...23
    private let minutes = 0...59
    private let seconds = 0...59

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 创建视图
        setupSubviews()
    }

    // 创建视图
    private func setupSubviews() {
        
        // 设置 UIPickerView 属性
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.selectRow(0, inComponent: 0, animated: true)
        
        // 设置 UILabel 属性
        dateLabel.textColor = .green
        dateLabel.textAlignment = .center
        dateLabel.font = UIFont.systemFont(ofSize: 21)
        
        // 设置 UIButton 属性
        randomButton.setTitle("随机选择", for: .normal)
        randomButton.setTitleColor(.green, for: .normal)
        randomButton.titleLabel?.font = UIFont.systemFont(ofSize: 21)
        randomButton.addTarget(self, action: #selector(randomButtonAction), for: .touchUpInside)
        
        // 新增视图
        view.addSubview(pickerView)
        view.addSubview(dateLabel)
        view.addSubview(randomButton)
        
        // 设置约束
        pickerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        dateLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(pickerView.snp.top).offset(-34)
        }
        randomButton.snp.makeConstraints { make in
            make.top.equalTo(pickerView.snp.bottom).offset(34)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(30)
        }
        
        // 刷新选中时间
        refreshSelectedDate()
    }
    
    // 刷新选中时间
    private func refreshSelectedDate() {
        dateLabel.text = "\(pickerView.selectedRow(inComponent: 0)) 时 \(pickerView.selectedRow(inComponent: 1)) 分 \(pickerView.selectedRow(inComponent: 2)) 秒"
    }
    
    // MARK: Action
    
    @objc private func randomButtonAction() {
        pickerView.selectRow(Int(arc4random()) % hours.count, inComponent: 0, animated: true)
        pickerView.selectRow(Int(arc4random()) % minutes.count, inComponent: 1, animated: true)
        pickerView.selectRow(Int(arc4random()) % seconds.count, inComponent: 2, animated: true)
        // 刷新选中时间
        refreshSelectedDate()
    }
    
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return ScreenSizeUtils.SCREEN_WIDTH/3.0
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 25
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // 刷新选中时间
        refreshSelectedDate()
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        // 初始化
        let itemLabel = UILabel()
        itemLabel.textColor = .white
        itemLabel.textAlignment = .center
        itemLabel.font = UIFont.systemFont(ofSize: 18)
        // 区分
        switch component {
        case 0:
            itemLabel.text = String(Array(hours)[row]) + "时"
        case 1:
            itemLabel.text = String(Array(minutes)[row]) + "分"
        case 2:
            itemLabel.text = String(Array(seconds)[row]) + "秒"
        default:
            itemLabel.text = ""
        }
        return itemLabel
    }
    
    // MARK: UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return hours.count
        case 1:
            return minutes.count
        case 2:
            return seconds.count
        default:
            return 0
        }
    }
}

