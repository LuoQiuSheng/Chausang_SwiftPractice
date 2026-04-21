//
//  ViewController.swift
//  CollectionViewAnimation
//
//  Created by Metalien on 2026/4/20.
//

import UIKit

class ViewController: UIViewController {
    
    let screenWidth = ScreenSizeUtils.SCREEN_WIDTH
    let screenHeight = ScreenSizeUtils.SCREEN_HEIGHT
    let itemWidth = ScreenSizeUtils.SCREEN_WIDTH-20
    let itemHeight = ScreenSizeUtils.SCREEN_HEIGHT/3-20
    
    var mainCollectionView: UICollectionView!
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
    }

}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CustomCollectionViewCell
        return cell
    }
    
}

