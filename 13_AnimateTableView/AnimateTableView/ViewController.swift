//
//  ViewController.swift
//  AnimateTableView
//
//  Created by Metalien on 2026/3/26.
//

import UIKit
import SnapKit


let kDataSourceCount = 30


class ViewController: UIViewController {
    
    let mainTableView = UITableView(frame: CGRectZero, style: .plain)
    let reuseCellIdentifier = "CustomReuseCellIdentifier"
    var isLoaded = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 创建视图
        setupSubviews()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        // 开始动画加载列表
        startAnimateTableView()
    }

    /// 创建视图
    private func setupSubviews() {
        
        // 初始化
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.separatorStyle = .none
        mainTableView.contentInsetAdjustmentBehavior = .never
        mainTableView.automaticallyAdjustsScrollIndicatorInsets = false
        mainTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: reuseCellIdentifier)
        
        // 添加视图
        view.addSubview(mainTableView)
        
        // 设置约束
        mainTableView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
    
    /// 开始动画加载列表
    private func startAnimateTableView() {
        // 标记状态
        isLoaded = true
        // 刷新数据
        mainTableView.reloadData()
        // 更新约束
        mainTableView.layoutIfNeeded()
        // 所有可见的cell
        let cells = mainTableView.visibleCells
        let tableHeight = mainTableView.bounds.size.height
        // 遍历枚举
        for (index, cell) in cells.enumerated() {
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
            // 动画效果
            UIView.animate(withDuration: 1.0,
                           delay: 0.05 * Double(index),
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: [],
                           animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
        }
    }
    
    /// 创建视图颜色
    private func setContentBackgroundColorAtIndex(index: Int) -> UIColor {
        let color = (CGFloat(index)/CGFloat(kDataSourceCount))*0.6
        return UIColor(red: 1.0, green: color, blue: 0.0, alpha: 1.0)
    }
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isLoaded {
            return kDataSourceCount
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseCellIdentifier, for: indexPath)
        cell.textLabel?.text = "第 \(indexPath.row+1) 行数据"
        cell.textLabel?.textColor = .white
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.backgroundColor = .clear
        cell.textLabel?.font = UIFont(name: "Avenir Next", size: 18)
        cell.selectionStyle = .gray
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = setContentBackgroundColorAtIndex(index: indexPath.row)
    }
    
}

