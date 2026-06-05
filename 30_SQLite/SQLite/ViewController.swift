//
//  ViewController.swift
//  SQLite
//
//  Created by Metalien on 2026/6/2.
//

import UIKit
import SnapKit

let kTableName = "MTL"

class ViewController: UIViewController {
    
    let reuseIdentifier = String(describing: UITableViewCell.self)
    var tableView: UITableView!
    var dataSource: [Dictionary <String, String>]? {
        return DBManager.getData(kTableName, nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置标题
        title = "数据列表"
        // 设置导航栏按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddUserAlertController))
//        // 创建表
//        DBManager.createTable(kTableName, "name TEXT, password TEXT")
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
    
    // 展示删除用户提示弹窗
    private func showDeleteUserAlertController(_ indexPath: IndexPath) {
        
        let alertController = UIAlertController(title: "确认删除？", message: "删除后无法恢复", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (action) in
            self.tableView.reloadRows(at: [indexPath], with: .fade)
        }
        let deleteAction = UIAlertAction(title: "删除", style: .destructive) { (action) in
            guard let dic = self.dataSource?[indexPath.row] else { return }
            // 删除数据库
            DBManager.deleteData(kTableName, "name = '\(dic["name"]!)'")
            // 刷新 UI
            self.tableView.reloadData()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        self.present(alertController, animated: true)
    }
    
    // MARK: - Action
    
    // 展示添加用户提示弹窗
    @objc private func showAddUserAlertController() {
        
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
            let dic = ["name": name, "password": pwd]
            // 增
            DBManager.saveData(kTableName, dic)
            // 刷新 UI
            self.tableView.reloadData()
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
        return dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) ?? UITableViewCell(style: .value1, reuseIdentifier: reuseIdentifier)
        let dic = dataSource![indexPath.row]
        cell.textLabel?.text = "用户名：" + dic["name"]!
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
        cell.textLabel?.textColor = .orange
        cell.detailTextLabel?.text = "密码：" + dic["password"]!
        return cell
    }
    
    // MARK: - Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // 创建删除按钮
        let deleteAction = UIContextualAction(style: .destructive, title: "删除") { (action, view, completion) in
            // 在这里写删除逻辑
            print("删除第 \(indexPath.row) 行")
            // 展示删除用户提示弹窗
            self.showDeleteUserAlertController(indexPath)
            // 执行完告诉系统动作完成
            completion(true)
        }
        deleteAction.backgroundColor = .red
        // 返回配置
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
}

