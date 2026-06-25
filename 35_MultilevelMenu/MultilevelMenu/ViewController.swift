//
//  ViewController.swift
//  MultilevelMenu
//
//  Created by Metalien on 2026/6/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let mainTableView = UITableView(frame: .zero, style: .grouped)
    let reuseIdentifier = String(describing: UITableViewCell.self)
    let reuseHeaderIdentifier = String(describing: ProvinceHeaderView.self)
    var dataSource = getAllProvinceData()

    override func viewDidLoad() {
        super.viewDidLoad()
        // 创建视图
        setupSubviews()
    }

    // 创建视图
    private func setupSubviews() {
        
        mainTableView.backgroundColor = .white
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(ProvinceHeaderView.self, forHeaderFooterViewReuseIdentifier: reuseHeaderIdentifier)
        view.addSubview(mainTableView)
        mainTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // 点击处理
    private func headerTapAction(section: Int) {
        // 切换展开状态
        dataSource[section].isOpen.toggle()
        mainTableView.reloadSections([section], with: .automatic)
    }

}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let province = dataSource[section]
        return province.isOpen ? province.citys.count:0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let city = dataSource[indexPath.section].citys[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) ?? UITableViewCell(style: .value1, reuseIdentifier: reuseIdentifier)
        cell.textLabel?.text = city.name
        cell.textLabel?.textColor = .gray
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.detailTextLabel?.text = city.alias
        cell.detailTextLabel?.textColor = .gray
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 12)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let province = dataSource[section]
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseHeaderIdentifier) as! ProvinceHeaderView
        view.reloadData(province, section)
        // 点击回调
        view.headerTapBlock = { [weak self] tapSection in
            self?.headerTapAction(section: tapSection)
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFLOAT_MIN
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

