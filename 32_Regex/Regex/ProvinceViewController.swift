//
//  ProvinceViewController.swift
//  Regex
//
//  Created by Metalien on 2026/6/9.
//

import UIKit
import SnapKit

class ProvinceViewController: UIViewController {
    
    var province: ProvinceModel!
    var mainTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // 标题
        title = province.name
        // 创建视图
        setupSubviews()
    }
    
    // 创建视图
    private func setupSubviews() {
        
        // 创建 UITextView
        mainTextView = UITextView()
        mainTextView.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(3))
        mainTextView.textColor = .orange
        mainTextView.isEditable = false
        mainTextView.showsVerticalScrollIndicator = false
        mainTextView.showsHorizontalScrollIndicator = false
        view.addSubview(mainTextView)
        mainTextView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(ScreenSizeUtils.NAVGATION_HEIGHT + 12)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(ScreenSizeUtils.BOTTOM_SAFE_AREA_HEIGHT)
        }
        
        // 加载数据
        loadProvinceData()
    }
    
    // 加载数据
    private func loadProvinceData() {
        var string = "省会名称：\(province.name)\n拥有\(province.cities.count)个市\n"
        for city in province.cities {
            string = "\(string)\n市名：\(city.name)\n别名：\(city.aliases)\n"
        }
        mainTextView.text = string
        
    }

}
