//
//  UICollectionViewWaterFallLayout.swift
//  CustomCollectionLayout
//
//  Created by Metalien on 2026/5/29.
//

import UIKit

protocol UICollectionViewWaterFallLayoutDelegate: NSObjectProtocol {
    // 设置高度
    func heightForItemAtIndexPath(indexPath: IndexPath) -> CGFloat
}

class UICollectionViewWaterFallLayout: UICollectionViewLayout {

    // 间隙
    var itemSpace: CGFloat = 5
    weak var delegate: UICollectionViewWaterFallLayoutDelegate?
    
    // 缓存
    private var layoutAttributes = [UICollectionViewLayoutAttributes]()
    private var maxYOfColums = [CGFloat]()
    private var oldScreenWidth: CGFloat = 0
    
    // 列
    var numberOfColums = 0 {
        didSet {
            for _ in 0 ..< numberOfColums {
                maxYOfColums.append(0)
            }
        }
    }
    
    override func prepare() {
        super.prepare()
        layoutAttributes = calculateLayoutAttributes()
        oldScreenWidth = ScreenSizeUtils.SCREEN_WIDTH
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return layoutAttributes[indexPath.row]
    }
    
    // 必须重写
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttributes
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: 0, height: maxYOfColums.max()!)
    }
    
    // 旋转屏幕后刷新视图
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return newBounds.width != oldScreenWidth
    }
    
    // 计算所有的 UICollectionViewLayoutAttributes
    private func calculateLayoutAttributes() -> [UICollectionViewLayoutAttributes] {
        
        let totalNums = collectionView!.numberOfItems(inSection: 0)
        let width = (collectionView!.bounds.width - itemSpace * CGFloat(numberOfColums + 1)) / CGFloat(numberOfColums)
        
        var x: CGFloat
        var y: CGFloat
        var height: CGFloat
        var currentColum: Int
        var indexPath: IndexPath
        var attributesArr: [UICollectionViewLayoutAttributes] = []
        
        guard let unwapDelegate = delegate else {
            assert(false, "需要设置代理")
            return attributesArr
        }
        
        for index in 0..<numberOfColums {
            self.maxYOfColums[index] = 0
        }
        
        for currentIndex in 0..<totalNums {
            indexPath = IndexPath(item: currentIndex, section: 0)
            height = unwapDelegate.heightForItemAtIndexPath(indexPath: indexPath)
            // 第一行直接添加到当前的列
            if currentIndex < numberOfColums {
                currentColum = currentIndex
            }
            // 其他行添加到最短的那一列
            else {
                // 这里使用!会得到期望的值
                let minMaxY = maxYOfColums.min()!
                currentColum = maxYOfColums.firstIndex(of: minMaxY)!
            }
            //            currentColum = currentIndex % numberOfColums
            x = itemSpace + CGFloat(currentColum) * (width + itemSpace)
            // 每个cell的y
            y = itemSpace + maxYOfColums[currentColum]
            // 记录每一列的最后一个cell的最大Y
            maxYOfColums[currentColum] = y + height
            // 设置用于瀑布流效果
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = CGRect(x: x, y: y, width: width, height: height)
            // 添加
            attributesArr.append(attributes)
        }
        return attributesArr
    }
}



