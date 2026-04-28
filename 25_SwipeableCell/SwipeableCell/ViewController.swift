//
//  ViewController.swift
//  SwipeableCell
//
//  Created by Chausang on 2026/4/28.
//

import UIKit

class ViewController: UIViewController {
    
    let mainTableView = UITableView(frame: CGRectZero, style: .plain)

    override func viewDidLoad() {
        super.viewDidLoad()
        // 创建视图
        setupSubviews()
    }

    // 创建视图
    private func setupSubviews() {
        
        // UITableView 初始化
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(nil, forCellReuseIdentifier: "")
        
        // 添加视图
    }

}

