//
//  ViewController.swift
//  SortableCollectionView
//
//  Created by Chausang on 2026/5/6.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    
    var collectionView: SortableCollectionView!
    var dataSource = [UIColor]()
    let reuseIdentifier = String(describing: UITableViewCell.self)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // 创建视图
        setupSubviews()
    }


    // 创建视图
    private func setupSubviews() {
        
        // 创建数据源
        for _ in 0...40 {
            dataSource.append(UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0))
        }
        
        // 创建布局样式
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: (ScreenSizeUtils.SCREEN_WIDTH-40)/3, height: (ScreenSizeUtils.SCREEN_WIDTH-40)/3)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        // 创建 CollectionView
        collectionView = SortableCollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.sortableDelegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, SortableCollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = dataSource[indexPath.row]
        // 先判断有没有label，没有就创建并添加
        let labelTag = 100
        var textLabel: UILabel!
        if let existingLabel = cell.viewWithTag(labelTag) as? UILabel {
            textLabel = existingLabel
        } else {
            textLabel = UILabel(frame: cell.bounds)
            textLabel.tag = labelTag
            textLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            textLabel.textAlignment = .center
            cell.addSubview(textLabel)
        }
        textLabel.text = "第\(indexPath.row+1)个"
        return cell
    }
    
    // 改变数据
    func exchangeDataSource(fromIndex: IndexPath, toIndex: IndexPath) {
        
//        let temp = dataSource[fromIndex.row]
//        dataSource[fromIndex.row] = dataSource[toIndex.row]
//        dataSource[toIndex.row] = temp
        
        // 交换数据源
        dataSource.swapAt(fromIndex.row, toIndex.row)
        print("fromIndex:\(fromIndex), toIndex:\(toIndex)")
    }
    
    // 开始拖动
    func beginDragAndInitDragCell(collectionView: SortableCollectionView, dragCell: UIView) {
        dragCell.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        dragCell.backgroundColor = .lightGray
    }
    
    // 拖动结束
    func endDragAndResetDragCell(collectionView: SortableCollectionView, dragCell: UIView) {
        dragCell.transform = CGAffineTransform(scaleX: 1, y: 1)
        dragCell.backgroundColor = .white
    }
}

