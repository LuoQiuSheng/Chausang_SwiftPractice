//
//  ViewController.swift
//  WelcomView
//
//  Created by Metalien on 2026/2/6.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    var currentPage = 0
    let imageNames = ["first","second","three"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 加载视图
        setupSubviews()
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        // 获取视图尺寸
//        let tempSize = view.bounds
//        // 设置 UIScrollView
//        mainScrollView.frame = tempSize
//        mainScrollView.contentSize = CGSize(width: tempSize.width*CGFloat(imageNames.count), height: tempSize.height)
//        // 设置 UIPageControl
//        mainPageControl.frame = CGRect(x: 0, y: tempSize.height-30, width: tempSize.width, height: 20)
//    }
    
    
    // MARK: Private

    /// 加载视图
    private func setupSubviews() {
        
        
        
//        // 新增图片
//        for (index, value) in imageNames.enumerated() {
//            let imageView = UIImageView()
//            imageView.image = UIImage(named: value)
//            imageView.clipsToBounds = true
//            imageView.contentMode = .scaleAspectFill
//            mainScrollView .addSubview(imageView)
//            
//        }
        
//        // 设置 UIScrollView
//        mainScrollView.frame = CGRect(x: 0, y: 0, width: ScreenInfoManager.width, height: ScreenInfoManager.height)
//        mainScrollView.contentSize = CGSize(width: ScreenInfoManager.width*CGFloat(imageNames.count), height: ScreenInfoManager.height)
        
        // UIPageControl
//        mainPageControl.frame = CGRect(x: 0, y: ScreenInfoManager.height-30, width: ScreenInfoManager.width, height: 20)
        mainPageControl.currentPage = currentPage
        mainPageControl.numberOfPages = imageNames.count
        
        // 添加视图
        view.addSubview(mainScrollView)
        view.addSubview(mainPageControl)
        
        
    }
    
    
    // MARK: UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let number = Int(round(mainScrollView.contentOffset.x/ScreenInfoManager.width))
//        if  number >= 0 && number <= 2 && number != currentPage {
//            currentPage = number
//            mainPageControl.currentPage = currentPage
//        }
    }
    

    // MARK: Lazy
    
    private lazy var mainScrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        return scrollView
    }()
    
    private lazy var mainPageControl : UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.isEnabled = false
        pageControl.pageIndicatorTintColor = .white
        pageControl.currentPageIndicatorTintColor = .gray
        return pageControl
    }()
}

