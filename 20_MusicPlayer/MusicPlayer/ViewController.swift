//
//  ViewController.swift
//  MusicPlayer
//
//  Created by Metalien on 2026/4/14.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    
    // 表单控件
    let mainTableView = UITableView(frame: CGRectZero, style: .plain)
    // 复用标识
    let reuseIdentifier = "MusicCellReuseIdentifier"
    // 数据源
    let dataSource = ["成都", "童话镇"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 创建视图
        setupSubviews()
    }


    // 创建视图
    private func setupSubviews() {
        // 新增视图
        view.addSubview(mainTableView)
        // 设置约束
        mainTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) ?? UITableViewCell(style: .default, reuseIdentifier: reuseIdentifier)
        cell.textLabel?.text = dataSource[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = .orange
        cell.textLabel?.font = UIFont.systemFont(ofSize: 30)
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
