//
//  PictureBrowseCollectionViewCell.swift
//  PictureBrowse
//
//  Created by Metalien on 2026/3/3.
//

import UIKit
import SnapKit

class PictureBrowseCollectionViewCell: UICollectionViewCell {
    
    private let featureImageView = UIImageView()
    private let titleLabel = UILabel()
    private let detailLabel = UILabel()
    
    var indexData: PictureBrowseModel? {
        /*
         属性观察器
         willSet 在新的值被设置之前调用
         didSet 在新的值被设置之后立即调用
         */
        didSet {
            // 更新数据源
            updatePrictureBrowseModel()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        featureImageView.contentMode = .scaleAspectFill
        featureImageView.clipsToBounds = true
        
        titleLabel.backgroundColor = .gray
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        detailLabel.backgroundColor = .gray
        detailLabel.textColor = .white
        detailLabel.textAlignment = .center
        detailLabel.numberOfLines = 0
        detailLabel.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        
        // 添加视图
        contentView.addSubview(featureImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(detailLabel)
        
        // 设置约束
        featureImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        detailLabel.snp.makeConstraints { make in
            make.left.bottom.right.equalTo(contentView)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(detailLabel)
            make.bottom.equalTo(detailLabel.snp.top)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 更新数据源
    private func updatePrictureBrowseModel() {
        featureImageView.image = indexData?.featuredImage
        titleLabel.text = indexData?.title
        detailLabel.text = indexData?.descriptions
    }
    
}
