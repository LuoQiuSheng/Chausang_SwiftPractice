//
//  ViewController.swift
//  SystemRefreshControl
//
//  Created by Metalien on 2026/3/24.
//

import UIKit
import SnapKit


class ViewController: UIViewController {
    
    let mainTableView = UITableView(frame: CGRectZero, style: .plain)
    let refreshControl = UIRefreshControl()
    let cellIdentifier = "RefreshCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 背景色
        view.backgroundColor = .green
        // 创建视图
        setupSubviews()
    }

    
    /// 创建视图
    private func setupSubviews() {
        
        // 刷新框架
        refreshControl.backgroundColor = .white
        refreshControl.tintColor = .lightGray
        refreshControl.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        refreshControl.addTarget(self, action: #selector(mainTableViewHeaderRefresh), for: .valueChanged)
        
        // 表单
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.showsVerticalScrollIndicator = false
        mainTableView.showsHorizontalScrollIndicator = false
        mainTableView.separatorStyle = .none
        mainTableView.refreshControl = refreshControl;
        mainTableView.tableFooterView = UIView()
        
        // 新增视图
        view.addSubview(mainTableView)
        // 设置约束
        mainTableView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
    
    // MARK: Action
    
    @objc private func mainTableViewHeaderRefresh() {
        // 刷新数据
        mainTableView.reloadData()
        // 延迟 2 秒执行（改成你想要的秒数）
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // 在这里写你要延迟执行的代码
            print("延迟2秒后执行")
            // 结束刷新
            self.refreshControl.endRefreshing()
        }
    }
    
}


// MARK: 扩展

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    // 每组有多少行
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    // 每一行显示什么 cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) ?? UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        cell.textLabel?.text = "第 \(indexPath.row) 行"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
