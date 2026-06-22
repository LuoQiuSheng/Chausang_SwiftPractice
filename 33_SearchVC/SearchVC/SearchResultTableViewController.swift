//
//  SearchResultTableViewController.swift
//  SearchVC
//
//  Created by Metalien on 2026/6/22.
//

import UIKit

class SearchResultTableViewController: UITableViewController {
    
    var dataSource = [ProvinceModel]()
    let reuseIdentifier = String(describing: UITableViewCell.self)

    override func viewDidLoad() {
        super.viewDidLoad()
        // 禁止自动预留顶部空白
        tableView.contentInsetAdjustmentBehavior = .never
    }
    
//    // 选中处理
//    private func didSelectRowAt(_ indexPath: IndexPath) {
//        let showVC = ShowProvinceDetailViewController()
//        showVC.province = dataSource[indexPath.row]
//        self.navigationController?.pushViewController(showVC, animated: true)
//    }
    
//    // MARK: - UITableViewDelegate
//    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 50
//    }
//    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        // 选中处理
//        didSelectRowAt(indexPath)
//    }

    // MARK: - UITableViewDelegate

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) ?? UITableViewCell(style: .default, reuseIdentifier: reuseIdentifier)
        cell.textLabel?.text = dataSource[indexPath.row].name
        cell.textLabel?.textColor = .black
        return cell
    }
    
    

}
