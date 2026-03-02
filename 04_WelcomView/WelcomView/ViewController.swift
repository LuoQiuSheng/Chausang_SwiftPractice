//
//  ViewController.swift
//  WelcomView
//
//  Created by Metalien on 2026/2/6.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    private lazy var mainScrollView = UIScrollView()
    private lazy var mainPageControl = UIPageControl()
    private var currentPage = 0
    private let imageNames = ["first","second","three"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 加载视图
        setupSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // 确保在布局完成后设置 contentSize
        mainScrollView.contentSize = CGSize(
            width: mainScrollView.bounds.width * CGFloat(imageNames.count),
            height: mainScrollView.bounds.height
        )
    }
    
    // MARK: Private

    /// 加载视图
    private func setupSubviews() {
        
        
        // 设置 UIScrollView
        mainScrollView.delegate = self
        mainScrollView.isPagingEnabled = true
        mainScrollView.showsVerticalScrollIndicator = false
        mainScrollView.showsHorizontalScrollIndicator = false
        
        // UIPageControl
        mainPageControl.currentPage = currentPage
        mainPageControl.numberOfPages = imageNames.count
        mainPageControl.isEnabled = false
        mainPageControl.pageIndicatorTintColor = .white
        mainPageControl.currentPageIndicatorTintColor = .gray
        
        // 添加视图
        view.addSubview(mainScrollView)
        view.addSubview(mainPageControl)
        
        // 设置约束
        mainScrollView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        mainPageControl.snp.makeConstraints { make in
            make.left.right.equalTo(view)
            make.bottom.equalTo(view).offset(-30)
            make.height.equalTo(20)
        }
        
        
        // 新增图片
        for (index, value) in imageNames.enumerated() {
            let imageView = UIImageView()
            imageView.image = UIImage(named: value)
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleAspectFill
            mainScrollView.addSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.top.bottom.equalTo(mainScrollView)
                make.width.equalTo(mainScrollView)
                make.height.equalTo(mainScrollView)
                // 使用 snp 的宽度属性
                make.left.equalTo(mainScrollView.snp.left).offset(CGFloat(index) * UIScreen.main.bounds.width)
            }
        }
    }
    
    
    // MARK: UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let number = Int(round(mainScrollView.contentOffset.x/UIScreen.main.bounds.width))
        if  number >= 0 && number < imageNames.count && number != currentPage {
            currentPage = number
            mainPageControl.currentPage = currentPage
        }
    }
    
}

