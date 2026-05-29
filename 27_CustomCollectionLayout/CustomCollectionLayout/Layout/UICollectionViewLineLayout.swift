//
//  UICollectionViewLineLayout.swift
//  CustomCollectionLayout
//
//  Created by Metalien on 2026/5/29.
//

import UIKit

class UICollectionViewLineLayout: UICollectionViewFlowLayout {
    
    // 缓存布局
    private var layoutAttributes = [UICollectionViewLayoutAttributes]()
    
    override func prepare() {
        super.prepare()
        scrollDirection = .horizontal
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let superLayoutAttributes = super.layoutAttributesForElements(in: rect)!
        let collectionViewCenterX = collectionView!.bounds.width * 0.5
        superLayoutAttributes.forEach { (attributes) in
            let copyLayout = attributes.copy() as! UICollectionViewLayoutAttributes
            // 中心点横向距离差
            let deltaX = abs(collectionViewCenterX - copyLayout.center.x + collectionView!.contentOffset.x)
            // 计算屏幕内的cell的transform
            if deltaX < collectionView!.bounds.width/2 {
                let scale = 1 - deltaX / collectionViewCenterX
                copyLayout.transform = CGAffineTransform(scaleX: scale, y: scale)
            } else {
                copyLayout.transform = CGAffineTransform(scaleX: 0, y: 0)
            }
            layoutAttributes.append(copyLayout)
        }
        return layoutAttributes
    }
    
    // 设置为true，滚动的时候实时更新布局
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

}
