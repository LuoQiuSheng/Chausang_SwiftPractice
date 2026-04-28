//
//  CustomCollectionViewCell.swift
//  CollectionViewAnimation
//
//  Created by Metalien on 2026/4/21.
//

import UIKit
import SnapKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    let textView = UITextView()
    let backButton = UIButton(type: .custom)
    
    var backButtonDidClick: (()->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 设置属性
        backgroundColor = .lightGray
        // 创建视图
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    // 创建视图
    private func setupSubviews() {
        
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.isUserInteractionEnabled = false
        
        backButton.isHidden = true
        backButton.setImage(UIImage(named: "Back-icon"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonAction(sender:)), for: .touchUpInside)
        
        // 添加视图
        contentView.addSubview(imageView)
        contentView.addSubview(textView)
        contentView.addSubview(backButton)
        
        // 设置约束
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        textView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(60)
        }
        backButton.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(10)
            make.size.equalTo(CGSizeMake(40, 40))
        }
    }
    
    // MARK: - Action
    
    // 返回按钮
    @objc private func backButtonAction(sender: UIButton) {
        // 隐藏按钮
        sender.isHidden = true
        // 闭包
        backButtonDidClick!()
    }
    
    // MARK: - Public
    
    // 加载数据
    public func prepareCell(model: CustomModel) {
        imageView.image = UIImage(named: model.imageName)
        textView.text = model.title
    }
    
    // 选中处理
    public func cellDidSelect() {
        backButton.isHidden = false
        superview?.bringSubviewToFront(self)
    }
    
}
