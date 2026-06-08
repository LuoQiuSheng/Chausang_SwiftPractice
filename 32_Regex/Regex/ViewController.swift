//
//  ViewController.swift
//  Regex
//
//  Created by Metalien on 2026/6/8.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var provinces = [Province]()
    var mainTableView: UITableView!
    let reuseIdentifier = String(describing: UITableViewCell.self)

    override func viewDidLoad() {
        super.viewDidLoad()
        // 创建视图
        setupSubviews()
    }

    // 创建视图
    private func setupSubviews() {
        
    }
}

// MARK: - 数据处理扩展

extension ViewController {
    
    // 返回省数组
    private func regexProvinces() -> [Province]? {
        
        var result = [Province]()
        
        do {
            
            let file = try String(contentsOfFile: Bundle.main.path(forResource: "location", ofType: "html")!, encoding: .utf8)
            
            
        } catch {
            
        }
        
        return result
    }
}
