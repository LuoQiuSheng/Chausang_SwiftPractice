//
//  ViewController.swift
//  Regex
//
//  Created by Metalien on 2026/6/8.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    
    var mainTableView: UITableView!
    let reuseIdentifier = String(describing: UITableViewCell.self)
    let allData: [ProvinceModel] = parseLocationHTML()
    // parseLocationHTML
    // getCityData

    override func viewDidLoad() {
        super.viewDidLoad()
        // 标题
        title = "全国省份列表"
        // 创建视图
        setupSubviews()
    }

    // 创建视图
    private func setupSubviews() {
        
        // 创建 UITableView
        mainTableView = UITableView(frame: CGRectZero, style: .plain)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.contentInsetAdjustmentBehavior = .never
        mainTableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(mainTableView)
        mainTableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(ScreenSizeUtils.NAVGATION_HEIGHT)
            make.left.bottom.right.equalToSuperview()
        }
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let province = allData[indexPath.row]
        cell.textLabel?.text = province.name
        cell.textLabel?.textColor = .orange
        return cell
    }
    
    // MARK: - Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // 创建视图控制器
        let vc = ProvinceViewController()
        vc.province = allData[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
