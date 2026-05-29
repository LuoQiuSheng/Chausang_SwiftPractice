//
//  ShowViewController.swift
//  CustomCollectionLayout
//
//  Created by Metalien on 2026/5/29.
//

import UIKit
import SnapKit

enum LayoutType: Int {
    case Waterfall = 0
    case Circle = 1
    case Line = 2
}

class ShowViewController: UIViewController {
    
    var type: LayoutType = .Waterfall
    var collectionView: UICollectionView!
    let reuseIdentifier = String(describing: UICollectionViewCell.self)
    var count = 0
    var heightDataSource = [CGFloat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 创建视图
        setupSubviews()
    }
    
    // 创建视图
    private func setupSubviews() {
        
        // 创建视图
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // 区分类型
        switch self.type {
        case .Waterfall:
            // 默认个数
            count = 100
            // 遍历添加随机高度
            for _ in 0..<self.count {
                heightDataSource.append(CGFloat(arc4random() % 150 + 40))
            }
            // 创建瀑布流样式布局
            setupWaterfallLayout()
        case .Circle:
            // 默认个数
            count = 10
            // 创建圆形样式布局
            setupCircleLayout()
        case .Line:
            // 默认个数
            count = 100
            // 创建线性样式布局
            setupLineLayout()
        }
    }
    
    // 创建瀑布流样式布局
    private func setupWaterfallLayout() {
        let layout = UICollectionViewWaterFallLayout()
        layout.delegate = self
        layout.numberOfColums = 2
        collectionView.collectionViewLayout = layout
    }
    
    // 创建圆形样式布局
    private func setupCircleLayout() {
        let layout = UICollectionViewCircleLayout()
        collectionView.collectionViewLayout = layout
    }
    
    // 创建线性样式布局
    private func setupLineLayout() {
        let layout = UICollectionViewLineLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        collectionView.collectionViewLayout = layout
    }

}


extension ShowViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewWaterFallLayoutDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
        return cell
    }
    
    func heightForItemAtIndexPath(indexPath: IndexPath) -> CGFloat {
        return heightDataSource[indexPath.row]
    }
}
