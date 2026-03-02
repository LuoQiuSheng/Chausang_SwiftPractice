//
//  ViewController.swift
//  PictureBrowse
//
//  Created by Metalien on 2026/3/2.
//

import UIKit

class ViewController: UIViewController {
    
    
    private lazy var backgroundImageView = UIImageView(image: UIImage(named: "blue"))
    private let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    private let reuseIdentifer = "pictureBrowseReuseIdentifier"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 设置背景颜色
        view.backgroundColor = .white
    }


}

