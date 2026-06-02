//
//  ViewController.swift
//  SQLite
//
//  Created by Metalien on 2026/6/2.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var tableView: UITableView!
    var dataSource = [Any]()
    let reuseIdentifier = String(describing: UITableViewCell.self)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置标题
        title = "数据列表"
        // 设置导航栏按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightBarButtonItemAction))
        // 创建视图
        setupSubviews()
    }

    // 创建视图
    private func setupSubviews() {
        
        // 创建 UITableView
        tableView = UITableView(frame: CGRectZero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        // 添加视图
        view.addSubview(tableView)
        // 设置约束
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Action
    @objc private func rightBarButtonItemAction() {
        
        let alertController = UIAlertController(title: "添加用户", message: "请输入用户名和密码", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel)
        let confirmAction = UIAlertAction(title: "确定", style: .destructive) { (_) in
            // 安全获取两个输入框
            guard let name = alertController.textFields?[0].text,
                  let pwd = alertController.textFields?[1].text,
                  !name.isEmpty,
                  !pwd.isEmpty else {
                return
            }
            print("用户名：\(name)，密码：\(pwd)")
        }
        // 添加输入框
        alertController.addTextField { (textField) in
            textField.placeholder = "请输入用户名"
            textField.clearButtonMode = .whileEditing
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "请输入密码"
            textField.clearButtonMode = .whileEditing
        }
        // 添加按钮
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        self.present(alertController, animated: true)
    }
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) ?? UITableViewCell(style: .value1, reuseIdentifier: reuseIdentifier)
        return cell
    }
    
    // MARK: - Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        
//    }
}

