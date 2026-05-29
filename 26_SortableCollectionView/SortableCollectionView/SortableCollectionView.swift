//
//  SortableCollectionView.swift
//  SortableCollectionView
//
//  Created by Chausang on 2026/5/25.
//

import UIKit


@objc protocol SortableCollectionViewDelegate {
    // 开始拖动
    @objc optional func beginDragAndInitDragCell(collectionView: SortableCollectionView, dragCell: UIView)
    // 结束拖动（快照）
    @objc optional func endDragAndResetDragCell(collectionView: SortableCollectionView, dragCell: UIView)
    // 结束拖动（真实单元格）
    @objc optional func endDragAndOperateRealCell(collectionView: SortableCollectionView, dragCell: UIView, isMoved: Bool)
    // 交换数据
    @objc optional func exchangeDataSource(fromIndex: IndexPath, toIndex: IndexPath)
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
            // 更新移动
            updateMoveItem(viewPoint: viewPoint, collectionViewPoint: collectionViewPoint)
        }
        // 手势抬起
        else if sender.state == .ended {
            // 结束移动
            endMoveItem()
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
            let copiedView = copyable.copy(with: nil) as! UIView
            dragView = copiedView
        } else {
            // 该方法在模拟器里面无法获得快照，真机是可以的
            dragView = cell.snapshotView(afterScreenUpdates: false)
        }
        // 将快照添加到父view
        dragView.center = viewCenter
        dragView.autoresizesSubviews = false
        superview?.addSubview(dragView)
        bringSubviewToFront(dragView)
        // 触发代理-开始拖动
        sortableDelegate?.beginDragAndInitDragCell?(collectionView: self, dragCell: dragView)
    }
    
    // 更新移动
    private func updateMoveItem(viewPoint: CGPoint, collectionViewPoint: CGPoint) {
        // 移动快照位置
        dragView.center = viewPoint
        // 移动
        moveItemToPoint(collectionViewPoint: collectionViewPoint)
        // 边缘滚动
        scrollAtEdge()
    }
    
    // 移动结束
    private func endMoveItem() {
        // 移动定时器
        timer?.invalidate()
        timer = nil
        // 获取指定单元格
        if let origin = originCell {
            UIView.animate(withDuration: 0.2) {
                // 协议
                self.sortableDelegate?.endDragAndResetDragCell?(collectionView: self, dragCell:  self.dragView)
                // 重置尺寸
                let rect = origin.frame
                self.dragView.frame = CGRect(x: rect.origin.x, y: rect.origin.y - self.contentOffset.y, width: rect.width, height: rect.height)
            } completion: { (finish) in
                // 移除视图
                self.dragView.removeFromSuperview()
                // 显示
                origin.isHidden = false
                // 判断是否已移动
                var isMoved = false
                if let toIndex = self.toIndex {
                    // 交换数据
                    self.sortableDelegate?.exchangeDataSource?(fromIndex: self.fromIndex, toIndex: toIndex)
                    isMoved = true
                }
                // 结束移动
                self.sortableDelegate?.endDragAndOperateRealCell?(collectionView: self, dragCell: origin, isMoved: isMoved)
            }
        }
    }
    
    // 移动
    private func moveItemToPoint(collectionViewPoint: CGPoint) {
        if let index = indexPathForItem(at: collectionViewPoint),
           let originCell = self.originCell {
            let cell = cellForItem(at: index)
            if cell != originCell {
                self.performBatchUpdates {
                    if let fromIndex = self.indexPath(for: originCell) {
                        self.moveItem(at: fromIndex, to: index)
                    }
                } completion: { (success) in
                    if success {
                        self.toIndex = index
                    }
                }
            }
        }
    }
    
    // 边缘滚动
    private func scrollAtEdge() {
        
        let pinTop = dragView.frame.origin.y
        let pinBottom = self.frame.height - (dragView.frame.origin.y + dragView.frame.height)
        
        var speed: CGFloat = 0
        var isTop: Bool = true
        
        if pinTop < 0 {
            speed = -pinTop
            isTop = true
        }
        else if pinBottom < 0 {
            speed = -pinBottom
            isTop = false
        }
        else {
            self.timer?.invalidate()
            self.timer = nil
            return
        }
        
        if let originTimer = self.timer,
            let originSpeed = (originTimer.userInfo as? [String:AnyObject])?["speed"] as? CGFloat {
            if abs(speed - originSpeed) > 10 {
                originTimer.invalidate()
                NSLog("speed:\(speed)")
                let timer = Timer(timeInterval: 1/60.0, target: self, selector: #selector(autoScroll(timer:)), userInfo: ["top":isTop,"speed": speed] , repeats: true)
                self.timer = timer
                RunLoop.main.add(timer, forMode: .common)
            }
        } else {
            let timer = Timer(timeInterval: 1/60.0, target: self, selector: #selector(autoScroll(timer:)), userInfo: ["top":isTop,"speed": speed] , repeats: true)
            self.timer = timer
            RunLoop.main.add(timer, forMode: .common)
        }
        
    }
    
    // 自动滚动
    @objc private func autoScroll(timer: Timer) {
        if let userInfo = timer.userInfo as? [String:AnyObject] {
            if let top =  userInfo["top"] as? Bool,let speed = userInfo["speed"] as? CGFloat {
                let offset = speed / 5
                let contentOffset = self.contentOffset
                if top {
                    self.contentOffset.y -= offset
                    self.contentOffset.y = self.contentOffset.y < 0 ? 0 : self.contentOffset.y
                }else {
                    self.contentOffset.y += offset
                    self.contentOffset.y = self.contentOffset.y > self.contentSize.height - self.frame.height ? self.contentSize.height - self.frame.height  : self.contentOffset.y
                }
                let point = CGPoint(x: dragView.center.x, y: dragView.center.y + contentOffset.y)
                self.moveItemToPoint(collectionViewPoint: point)
            }
        }
    }
    
}
