//
//  ViewController.swift
//  TableHeaderView
//
//  Created by Metalien on 2026/3/26.
//

import UIKit
import SnapKit
import Kingfisher

let kHeaderImageViewHeight = ScreenSizeUtils.SCREEN_HEIGHT/3.0

class ViewController: UIViewController {
    
    let mainTableView = UITableView(frame: CGRectZero, style: .plain)
    let headerImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: ScreenSizeUtils.SCREEN_WIDTH, height: kHeaderImageViewHeight))
    let reuseIdentifier = "CustomCellReuseIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 创建视图
        setupSubviews()
    }

    /// 创建视图
    private func setupSubviews() {
        
        // 加载网络图片
        headerImageView.kf.setImage(
            with: URL(string: "https://b0.bdstatic.com/ugc/personal_page_creator/68Hk7rhJv7Im1ltWO3X5sQfb4bc2900b590de60be36c2d11478ac2.jpg"), // 图片URL
            placeholder: nil, // 占位图
            options: [.transition(.fade(0.2))] // 淡入动画（可选）
        )
        
        // Header 初始化
        headerImageView.backgroundColor = .white
        headerImageView.contentMode = .scaleAspectFill
        headerImageView.clipsToBounds = true
        
        // TableView 初始化
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.backgroundColor = .white
        mainTableView.showsVerticalScrollIndicator = false
        mainTableView.contentInset.top = kHeaderImageViewHeight
        mainTableView.contentOffset = CGPoint(x: 0.0, y: -kHeaderImageViewHeight)
        mainTableView.automaticallyAdjustsScrollIndicatorInsets = false
        mainTableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        // 添加视图
        view.addSubview(mainTableView)
        view.addSubview(headerImageView)
        
        // 设置约束
        mainTableView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
    }
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = "第\(indexPath.row+1)行"
        cell.textLabel?.textAlignment = .center
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsety = scrollView.contentOffset.y + scrollView.contentInset.top
        if offsety <= 0 {
            headerImageView.frame = CGRect(x: 0.0, y: 0.0, width: ScreenSizeUtils.SCREEN_WIDTH, height: kHeaderImageViewHeight-offsety)
        }
        else {
            let height = (kHeaderImageViewHeight-offsety) <= 0.0 ? 0.0 : (kHeaderImageViewHeight-offsety)
            headerImageView.frame = CGRect(x: 0.0, y: 0.0, width: ScreenSizeUtils.SCREEN_WIDTH, height: height)
            headerImageView.alpha = height/kHeaderImageViewHeight
        }
    }
}
