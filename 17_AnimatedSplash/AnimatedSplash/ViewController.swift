//
//  ViewController.swift
//  AnimatedSplash
//
//  Created by Metalien on 2026/4/10.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 创建视图
        setupSubviews()
    }

    // 创建视图
    private func setupSubviews() {
        // 背景图
        let backgroundImageView = UIImageView(image: UIImage(named: "screen"))
        backgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}

