//
//  ViewController.swift
//  MosaicLayout
//
//  Created by Metalien on 2026/6/1.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var collectionView: UICollectionView!
    let imageNames = ["back","birds","sunset","waves"]
    let reuseIdentifier = String(describing: CustomCollectionViewCell.self)
    let reuseHeaderIdentifier = String(describing: CustomHeaderView.self)
    let HeaderFooterHeight: CGFloat = 44
    let ColumnCount = 2

    override func viewDidLoad() {
        super.viewDidLoad()
        // 创建视图
        setupSubviews()
    }

    // 创建视图
    private func setupSubviews() {
        
        // 创建布局
        let collectionLayout = FMMosaicLayout()
//        collectionLayout.delegate = self
        
        // 创建视图
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: collectionLayout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(CustomHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: reuseHeaderIdentifier)
        collectionView.register(CustomHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: reuseHeaderIdentifier)
        // 添加视图
        view.addSubview(collectionView)
        // 设置约束
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 22
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CustomCollectionViewCell
        cell.imageView.image = UIImage(named: imageNames[indexPath.row%4])
        cell.title.text = "第\(indexPath.row+1)个"
        return cell
    }
    
    // 设置分区头和weight
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let viewHF = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseHeaderIdentifier, for: indexPath) as! CustomHeaderView
        viewHF.title.text = kind == UICollectionView.elementKindSectionHeader ? "SECTION \(indexPath.section+1)" : "OVER SECTION \(indexPath.section+1)"
        return viewHF
    }
    
}


extension ViewController: FMMosaicLayoutDelegate {
    
    // 列
    func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!, numberOfColumnsInSection section: Int) -> Int {
        return ColumnCount
    }
    
    // item大小
    func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!, mosaicCellSizeForItemAt indexPath: IndexPath!) -> FMMosaicCellSize {
        return (indexPath.item % 12 == 0) ? FMMosaicCellSize.big : FMMosaicCellSize.small
    }
    
    // 分区内边距
    func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    // 分区间隔
    func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!, interitemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    // 头高
    func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!, heightForHeaderInSection section: Int) -> CGFloat {
        return HeaderFooterHeight
    }

    // 尾高
    func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!, heightForFooterInSection section: Int) -> CGFloat {
        return HeaderFooterHeight
    }

    // 控制分区头尾是否在collectionview之上
    func headerShouldOverlayContent(in collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!) -> Bool {
        return true
    }
    
    func footerShouldOverlayContent(in collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!) -> Bool {
        return true
    }
    
}

