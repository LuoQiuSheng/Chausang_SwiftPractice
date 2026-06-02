//
//  ViewController.swift
//  BasicAnimation
//
//  Created by Metalien on 2026/6/2.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var tableView: UITableView!
    let dataSource = ["位置","透明度","缩放","颜色","旋转"]
    let reuseIdentifier = String(describing: UITableViewCell.self)

    override func viewDidLoad() {
        super.viewDidLoad()
        // 创建视图
        setupSubviews()
    }

    // 创建视图
    private func setupSubviews() {
        
        // 创建 UITableView
        tableView = UITableView(frame: CGRectZero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        // 添加视图
        view.addSubview(tableView)
        // 设置约束
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // 选中
    private func itemDidSelectAt(_ indexPath: IndexPath) {
        let vc = AnimationViewController()
        vc.title = dataSource[indexPath.row]
        switch indexPath.row {
        case 0:
            vc.animationStyle = .position
        case 1:
            vc.animationStyle = .opacity
        case 2:
            vc.animationStyle = .scale
        case 3:
            vc.animationStyle = .color
        case 4:
            vc.animationStyle = .rotation
        default:
            break
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        cell.textLabel?.textColor = .black
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
        return cell
    }
    
    // MARK: - Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // 选中
        itemDidSelectAt(indexPath)
    }
}

