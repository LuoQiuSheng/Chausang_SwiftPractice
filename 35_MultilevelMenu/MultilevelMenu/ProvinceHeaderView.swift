//
//  ProvinceHeaderView.swift
//  MultilevelMenu
//
//  Created by Metalien on 2026/6/25.
//

import UIKit
import SnapKit

class ProvinceHeaderView: UITableViewHeaderFooterView {

    let arrowImageView = UIImageView()
    let titleLabel = UILabel()
    let detailLabel = UILabel()
    
    // 点击回调，外部控制器接收section
    var headerTapBlock: ((Int) -> Void)?
    var currentSection: Int = 0

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        // 创建视图
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 创建视图
    private func setupSubviews() {
        
        arrowImageView.contentMode = .scaleAspectFit
        
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textAlignment = .left
        
        detailLabel.font = UIFont.systemFont(ofSize: 14)
        detailLabel.textAlignment = .right
        
        addSubview(arrowImageView)
        addSubview(titleLabel)
        addSubview(detailLabel)
        
        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.size.equalTo(CGSizeMake(10, 10))
        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(arrowImageView.snp.right).offset(8)
        }
        detailLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
            make.left.greaterThanOrEqualTo(titleLabel.snp.right).offset(8)
        }
        
        // 创建点击手势
        setupTap()
    }
    
    // 创建点击手势
    private func setupTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        addGestureRecognizer(tap)
    }
    
    // 点击事件
    @objc private func tapAction() {
        headerTapBlock?(currentSection)
    }
    
    // 刷新数据
    public func reloadData(_ province: ProvinceModel, _ section: Int) {
        currentSection = section
        arrowImageView.image = UIImage(named: province.isOpen ? "Down":"Right")
        titleLabel.text = province.name
        detailLabel.text = String(province.citys.count)+"个市"
    }
    
}
