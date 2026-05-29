//
//  ViewController.swift
//  CustomCollectionLayout
//
//  Created by Metalien on 2026/5/29.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var tableView: UITableView!
    let reuseIdentifier = String(describing: UITableViewCell.self)
    let dataSource = ["瀑布流", "圆形", "线性"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // 创建视图
        setupSubviews()
    }
    
    // 创建视图
    private func setupSubviews() {
        
        // 创建表单
        tableView = UITableView(frame: CGRectZero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    // 跳转
    private func puthToShowViewController(indexPath: IndexPath) {
        let showVC = ShowViewController()
        switch indexPath.row {
        case 0:
            showVC.type = .Waterfall
        case 1:
            showVC.type = .Circle
        case 2:
            showVC.type = .Line
        default:
            break
        }
        navigationController?.pushViewController(showVC, animated: true)
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
        cell.textLabel?.textColor = .orange
        cell.textLabel?.textAlignment = .center
        return cell
    }
    
    // MARK: - Delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // 跳转
        puthToShowViewController(indexPath: indexPath);
    }
}

