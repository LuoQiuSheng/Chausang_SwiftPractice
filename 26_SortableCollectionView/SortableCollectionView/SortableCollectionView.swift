//
//  SortableCollectionView.swift
//  SortableCollectionView
//
//  Created by Chausang on 2026/5/25.
//

import UIKit

@objc protocol SortableCollectionViewDelegate {
    
}

class SortableCollectionView: UICollectionView {

    weak var sortableDelegate: SortableCollectionViewDelegate?
    var dragView: UIView!
    var originCell: UICollectionViewCell?
    var timer: Timer?
    
    var fromIndex: IndexPath!
    var toIndex: IndexPath?
    var isMovement = false

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        // 添加长按手势
        let pan = UILongPressGestureRecognizer(target: self, action: #selector(panHandler(sender:)))
        addGestureRecognizer(pan)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Gesture
    
    @objc func panHandler(sender: UILongPressGestureRecognizer) {
        
        // 手势点在collectionView的位置
        let collectionViewPoint = sender.location(in: self)
        // 手势点在父view的位置
        let viewPoint = sender.location(in: superview)
        // 手势按下
        if sender.state == .began {
            // 获得手势点的cell
            if let indexPath = indexPathForItem(at: collectionViewPoint),
               let originCell = cellForItem(at: indexPath) {
                // 开始移动
                beginMoveItemAtIndex(index: indexPath, cell: originCell, viewCenter: viewPoint)
            }
        }
        // 手势改变
        else if sender.state == .changed {
            
        }
        // 手势抬起
        else if sender.state == .ended {
            
        }
        
    }
}


extension SortableCollectionView {
    
    // 开始移动
    private func beginMoveItemAtIndex(index: IndexPath, cell: UICollectionViewCell, viewCenter: CGPoint) {
        // 缓存
        fromIndex = index
        originCell = cell
        // 隐藏
        cell.isHidden = true
        // 如果遵循了nscopying协议，并返回了副本的，可以用copy来获得view的副本
        if let copyable = originCell as? NSCopying {
            let copiedView = copyable.copy(with: nil) as! UIView {
                dragView = copiedView
            }
        } else {
            
        }
    }
}
