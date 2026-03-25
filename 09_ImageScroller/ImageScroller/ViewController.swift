//
//  ViewController.swift
//  ImageScroller
//
//  Created by Metalien on 2026/3/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let backgroundImageView = UIImageView(image: UIImage(named: "steve"));
    let backgrounVisual = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    let mainScrollView = UIScrollView()
    let mainImageView = UIImageView(image: UIImage(named: "steve"))
    // 记录图片原始尺寸
    let imageOriginalSize = CGSize(
        width: ScreenSizeUtils.SCREEN_WIDTH - 30*2,
        height: ScreenSizeUtils.SCREEN_WIDTH - 30*2
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        // 创建视图
        setupSubviews()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        recenterMainImageView()
    }

    /// 创建视图
    private func setupSubviews() {
        
        // 背景图
        backgroundImageView.clipsToBounds = true
        backgroundImageView.contentMode = .scaleAspectFill
        
        /*
         自动布局
         flexibleLeftMargin  自动调整view与父视图左边距，保证右边距不变
         flexibleWidth       自动调整view的宽度，保证左边距和右边距不变
         flexibleRightMargin 自动调整view与父视图右边距，以保证左边距不变
         flexibleTopMargin   自动调整view与父视图上边距，以保证下边距不变
         flexibleHeight      自动调整view的高度，以保证上边距和下边距不变
         flexibleBottomMargin自动调整view与父视图的下边距，以保证上边距不变
         */
        mainScrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mainScrollView.backgroundColor = .clear
        mainScrollView.delegate = self;
        mainScrollView.contentSize = imageOriginalSize
        mainScrollView.minimumZoomScale = 1
        mainScrollView.maximumZoomScale = 3.5
        
        // 视图
        mainImageView.clipsToBounds = true
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.frame = CGRect(origin: .zero, size: imageOriginalSize)
        
        // 新增视图
        view.addSubview(backgroundImageView)
        view.addSubview(backgrounVisual)
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(mainImageView)
        
        // 设置约束
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        backgrounVisual.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        mainScrollView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
    
    /// 重新定位图片
    private func recenterMainImageView() {
        let scrollViewSize = mainScrollView.bounds.size
        let contentSize = mainScrollView.contentSize
        
        let horizontal = max(0, (scrollViewSize.width - contentSize.width) / 2)
        let vertical = max(0, (scrollViewSize.height - contentSize.height) / 2)
        
        mainScrollView.contentInset = UIEdgeInsets(
            top: vertical,
            left: horizontal,
            bottom: vertical,
            right: horizontal
        )
    }

}


extension ViewController: UIScrollViewDelegate {
    
    // 要缩放时调用，返回需要缩放的view
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mainImageView
    }
    
    // 缩放后调用
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        // 重新定位图片
        recenterMainImageView()
    }
    
}
