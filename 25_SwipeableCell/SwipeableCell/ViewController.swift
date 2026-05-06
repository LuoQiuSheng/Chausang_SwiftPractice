//
//  ViewController.swift
//  SwipeableCell
//
//  Created by Chausang on 2026/4/28.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let mainTableView = UITableView(frame: CGRectZero, style: .plain)
    let reuseIdentifer = String(describing: CustomTableViewCell.self)
    var dataSource = [CellModel]()
    
    // MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置属性
        view.backgroundColor = .white
        // 创建视图
        setupSubviews()
    }
    
    // MARK: - Private

    // 创建视图
    private func setupSubviews() {
        // 创建数据源
        for index in 0...20 {
            dataSource.append(CellModel(imageName: String(index%3+1), title: "第\(index+1)行"))
        }
        // UITableView 初始化
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: reuseIdentifer)
        // 添加视图
        view.addSubview(mainTableView)
        // 设置约束
        mainTableView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.snp.bottomMargin)
        }
    }
    
    // MARK: - Event
    
    // 删除
    private func deleteCellAtIndexPath(indexPath: IndexPath) {
        let alertController = UIAlertController(title: "是否删除", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel)
        let confirmAction = UIAlertAction(title: "确定", style: .default) { action in
            self.dataSource.remove(at: indexPath.row)
            self.mainTableView.deleteRows(at: [indexPath], with: .fade)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        self.present(alertController, animated: true)
    }
    
    // 编辑
    private func editCellAtIndexPath(indexPath: IndexPath) {
        let alertController = UIAlertController(title: "修改名称", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel)
        let confirmAction = UIAlertAction(title: "确定", style: .default) { action in
            self.dataSource[indexPath.row].title = (alertController.textFields?.first?.text)!
            self.mainTableView.reloadRows(at: [indexPath], with: .fade)
        }
        alertController.addTextField { textField in
            textField.placeholder = "请输入名称"
            textField.text = self.dataSource[indexPath.row].title
            textField.clearButtonMode = .whileEditing
        }
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        self.present(alertController, animated: true)
    }
    
    // 分享
    private func shareCellAtIndexPath(indexPath: IndexPath) {
        let firstItem = self.dataSource[indexPath.row]
        let activityVC = UIActivityViewController(activityItems: [firstItem.title], applicationActivities: nil)
        self.present(activityVC, animated: true, completion: {
            self.mainTableView.reloadRows(at: [indexPath], with: .fade)
        })
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
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer, for: indexPath) as! CustomTableViewCell
        cell.prepareCell(model: dataSource[indexPath.row])
        return cell
    }
    
    // MARK: - Delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // 右滑出现按钮（
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // 创建删除按钮
        let deleteAction = UIContextualAction(style: .normal, title: "删除") { (action, view, completion) in
            print("删除第 \(indexPath.row) 行")
            // 删除
            self.deleteCellAtIndexPath(indexPath: indexPath)
            // 必须调用，结束操作
            completion(true)
        }
        // 自定义颜色
        deleteAction.backgroundColor = .red
        
        // 创建编辑按钮
        let editAction = UIContextualAction(style: .normal, title: "编辑") { (action, view, completion) in
            print("编辑第 \(indexPath.row) 行")
            // 编辑
            self.editCellAtIndexPath(indexPath: indexPath)
            // 必须调用，结束操作
            completion(true)
        }
        // 自定义颜色
        editAction.backgroundColor = .green
        
        // 分享按钮
        let shareAction = UIContextualAction(style: .normal, title: "分享") { (action, view, completion) in
            print("分享第 \(indexPath.row) 行")
            // 分享
            self.shareCellAtIndexPath(indexPath: indexPath)
            // 必须调用，结束操作
            completion(true)
        }
        // 自定义颜色
        shareAction.backgroundColor = .orange
        
        // 包装成配置返回
        let config = UISwipeActionsConfiguration(actions: [deleteAction, editAction, shareAction])
        return config
    }
}

