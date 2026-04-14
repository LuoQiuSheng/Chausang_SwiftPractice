//
//  TargetViewController.swift
//  CustomPushTransition
//
//  Created by Metalien on 2026/4/10.
//

import UIKit
import SnapKit

class TargetViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 遵循协议
        navigationController?.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // 隐藏导航栏
        navigationController?.navigationBar.isHidden = true
        // 创建视图
        setupSubviews()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        navigationController?.popViewController(animated: true)
    }
    
    // 创建视图
    private func setupSubviews() {
        
        // 背景图
        let backgroundImageView = UIImageView(image: UIImage(named: "8"))
        backgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }

}

extension TargetViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        if operation == .pop {
            return PopAnimation()
        }
        else {
            return nil
        }
    }
}
