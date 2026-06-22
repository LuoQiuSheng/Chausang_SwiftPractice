//
//  ScanView.swift
//  QRCode
//
//  Created by Metalien on 2026/6/22.
//

import UIKit

class ScanView: UIView {
    
    var lineLayer: CALayer!
    
    init() {
        super.init(frame: .zero)
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // 创建视图
    private func setupSubviews() {
        
    }
    
}
