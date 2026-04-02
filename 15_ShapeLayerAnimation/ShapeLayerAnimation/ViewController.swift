//
//  ViewController.swift
//  ShapeLayerAnimation
//
//  Created by Metalien on 2026/4/2.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var drawRectView = DrawRectView(frame: CGRectZero)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 设置属性
        title = "画图与动画"
        view.backgroundColor = .white
        // 创建视图
        setupSubviews()
    }

    /// 创建视图
    private func setupSubviews() {
        
        let button_1 = UIButton(type: .custom)
        button_1.setTitle("DrawRect", for: .normal)
        button_1.setTitleColor(.orange, for: .normal)
        button_1.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
        view.addSubview(button_1)
        button_1.snp.makeConstraints { make in
            make.top.equalTo(view).offset(200)
            make.left.right.equalTo(view).inset(100)
            make.height.equalTo(30)
        }
        
        let button_2 = UIButton(type: .custom)
        button_2.setTitle("CAShapeLayer", for: .normal)
        button_2.setTitleColor(.orange, for: .normal)
        button_2.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
        view.addSubview(button_2)
        button_2.snp.makeConstraints { make in
            make.top.equalTo(view).offset(300)
            make.left.right.equalTo(view).inset(100)
            make.height.equalTo(30)
        }
        
    }
    
    // MARK: Action
    
    @objc private func buttonAction(sender: UIButton) {
        if sender.currentTitle == "DrawRect" {
            print("采用 DrawRect 画图")
            // 新增视图
            view.addSubview(drawRectView)
            drawRectView.snp.makeConstraints { make in
                make.top.equalTo(view).offset(64)
                make.left.right.equalToSuperview()
                make.height.equalTo(view.snp.height)
            }
        }
        else {
            print("采用 CAShapeLayer")
            navigationController?.pushViewController(ShapeLayerAnimationViewController(), animated: true)
        }
    }

}

