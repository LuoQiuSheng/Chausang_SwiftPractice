//
//  ShowProvinceDetailViewController.swift
//  SearchVC
//
//  Created by Metalien on 2026/6/22.
//

import UIKit
import SnapKit

class ShowProvinceDetailViewController: UIViewController {
    
    var province: ProvinceModel!
    var provinceTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置标题
        title = province.name
        // 创建视图
        setupSubviews()
    }
    
    // 创建视图
    private func setupSubviews() {
        
        var string = "省会名称：\(province.name)\n拥有\(province.citys.count)个市\n"
        for city in province.citys {
            string = "\(string)\n市名：\(city.name)\n别名：\(city.alias)\n"
        }
        
        // 创建 UITextView
        provinceTextView = UITextView()
        provinceTextView.font = UIFont.systemFont(ofSize: 16)
        provinceTextView.text = string
        provinceTextView.textColor = .black
        provinceTextView.isEditable = false
        provinceTextView.showsVerticalScrollIndicator = false
        provinceTextView.showsHorizontalScrollIndicator = false
        view.addSubview(provinceTextView)
        provinceTextView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
        }
        
    }
    
}
