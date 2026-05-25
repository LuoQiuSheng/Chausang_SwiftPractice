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
    var dargView: UIView!
    var originCell: UITableViewCell?
    var timer: Timer?
    
    var fromIndex: IndexPath!
    var toIndex: IndexPath?
    var isMovement = false

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
