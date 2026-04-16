//
//  ViewController.swift
//  TumblrMenu
//
//  Created by Metalien on 2026/4/16.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let transitionManager = MenuTransitionManger()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 创建视图
        setupSubviews()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let vc = MenuViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.transitioningDelegate = transitionManager
        present(vc, animated: true, completion: nil)
    }

    // 创建视图
    private func setupSubviews() {
        
        // 创建背景图片
        let backgroundImageView = UIImageView(image: UIImage(named: "8"))
        backgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}

