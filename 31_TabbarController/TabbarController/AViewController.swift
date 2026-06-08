//
//  AViewController.swift
//  TabbarController
//
//  Created by Metalien on 2026/6/8.
//

import UIKit
import SnapKit

class AViewController: UIViewController {
    
    var mainTableView: UITableView!
    let reuseIdentifier = String(describing: UITableViewCell.self)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        // 创建视图
        setupSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 强制布局
        mainTableView.reloadData()
        mainTableView.layoutIfNeeded()
        // 动画显示
        animationShowTableViewCell()
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
            make.edges.equalToSuperview()
        }
        
    }
    
    // 动画显示
    private func animationShowTableViewCell() {
        // 获取当前所有可见的单元格
        let cells = mainTableView.visibleCells
        let height: CGFloat = ScreenSizeUtils.SCREEN_HEIGHT
        // 先把所有 Cell 瞬间移出屏幕下方（此时不需要动画，直接赋值）
        for tempCell_1 in cells {
            tempCell_1.transform = CGAffineTransform(translationX: 0, y: height)
        }
        // 顺次让它们回到自己原本该在的位置
        var index = 0
        for tempCell_2 in cells {
            UIView.animate(withDuration: 1.0,           // 动画时间（2秒有点慢，建议1.0~1.5秒左右）
                           delay: 0.05 * Double(index),  // 每个 Cell 之间微小的延迟，形成错落感
                           usingSpringWithDamping: 0.8,   // 弹性阻尼，越小弹得越厉害
                           initialSpringVelocity: 1,
                           options: [.curveEaseInOut],    // 淡入淡出曲线，让过渡更自然
                           animations: {
                
                // 让 Cell 恢复到原本在 Storyboard 或约束中定好的位置
                tempCell_2.transform = .identity
            }, completion: nil)
            
            index += 1
        }
    }

}

extension AViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = UIColor(red: .random(in: 0...1),
                                       green: .random(in: 0...1),
                                       blue: .random(in: 0...1),
                                       alpha: 1.0)
        return cell
    }
    
    // MARK: - Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 165
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
