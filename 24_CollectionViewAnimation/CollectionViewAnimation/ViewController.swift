//
//  ViewController.swift
//  CollectionViewAnimation
//
//  Created by Metalien on 2026/4/20.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let screenWidth = ScreenSizeUtils.SCREEN_WIDTH
    let screenHeight = ScreenSizeUtils.SCREEN_HEIGHT
    let itemWidth = ScreenSizeUtils.SCREEN_WIDTH-20
    let itemHeight = ScreenSizeUtils.SCREEN_HEIGHT/3-20
    
    var mainCollectionView: UICollectionView!
    var dataSource = CustomModel.getModel()
    let reuseIdentifier = String(describing: CustomCollectionViewCell.self)

    override func viewDidLoad() {
        super.viewDidLoad()
        // 创建视图
        setupSubviews()
    }

    // 创建视图
    private func setupSubviews() {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        flowLayout.minimumLineSpacing = 10 // 上下间隔
        flowLayout.minimumInteritemSpacing = 10 // 左右间隔
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        
        mainCollectionView = UICollectionView(frame: ScreenSizeUtils.SCREEN_RECT, collectionViewLayout: flowLayout)
        mainCollectionView.backgroundColor = .orange
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        mainCollectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // 添加视图
        view.addSubview(mainCollectionView)
        // 设置约束
        mainCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: ScreenSizeUtils.STATUSBAR_HEIGHT, left: 0, bottom: 0, right: 0))
        }
    }
    
    // MARK: - Event
    
    // 选中处理
    private func tableViewDidSelect(indexPath: IndexPath) {
        // 判断滚动状态
        if !mainCollectionView.isScrollEnabled {
            return
        }
        // 判断 cell 对象有效性
        guard let cell = mainCollectionView.cellForItem(at: indexPath) as? CustomCollectionViewCell else {
            return
        }
        // 禁止交互
        mainCollectionView.isScrollEnabled = false
        // 选中
        cell.cellDidSelect()
        // 返回
        cell.backButtonDidClick = {
            print("闭包执行")
            self.mainCollectionView.isScrollEnabled = true
            self.mainCollectionView.reloadItems(at: [indexPath])
        }
        // 动画效果
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: [],
                       animations: {
            
            cell.frame = CGRect(x: 0, y: self.mainCollectionView.contentOffset.y, width:ScreenSizeUtils.SCREEN_WIDTH , height: ScreenSizeUtils.SCREEN_HEIGHT - ScreenSizeUtils.STATUSBAR_HEIGHT)
            cell.imageView.frame = cell.bounds
            cell.textView.frame = CGRect(x: 0, y: cell.bounds.height-60, width: cell.bounds.width, height: 60)
            
        }) { (finish) in
            print("动画结束")
        }
        
    }

}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        // 选中处理
        tableViewDidSelect(indexPath: indexPath)
    }
    
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (dataSource?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CustomCollectionViewCell
        cell.prepareCell(model: (dataSource?[indexPath.row])!)
        return cell
    }
    
}

