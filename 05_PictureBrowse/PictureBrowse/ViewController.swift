//
//  ViewController.swift
//  PictureBrowse
//
//  Created by Metalien on 2026/3/2.
//

import UIKit
import SnapKit

let itemSizeWidth = ScreenModel.SCREEN_WIDTH-40.0
let itemSizeHeight = ScreenModel.SCREEN_HEIGHT/3.0

class ViewController: UIViewController {
    
    
    private lazy var backgroundImageView = UIImageView(image: UIImage(named: "blue"))
    private let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    private let reuseIdentifer = "pictureBrowseReuseIdentifier"
    private let dataSource = PictureBrowseModel.createPictureBrowseModels()
    
    private lazy var mainCollectionView: UICollectionView = {
        
        // 配置 layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: itemSizeWidth, height: itemSizeHeight)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PictureBrowseCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifer)
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 视图布局
        setupSubviews()
    }

    /// 视图布局
    private func setupSubviews() {
        
        // 添加视图
        view.addSubview(backgroundImageView)
        view.addSubview(visualEffectView)
        view.addSubview(mainCollectionView)
        
        // 设置约束
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        visualEffectView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        mainCollectionView.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.size.equalTo(CGSize(width: ScreenModel.SCREEN_WIDTH, height: itemSizeHeight))
        }
    }

}


/* 扩展 ViewController 支持协议 */

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {
    
    // MARK: UICollectionViewDataSource & UICollectionViewDelegate
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifer, for: indexPath) as! PictureBrowseCollectionViewCell
        cell.indexData = self.dataSource[indexPath.row]
        return cell
    }

}

