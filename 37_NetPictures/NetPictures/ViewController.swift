//
//  ViewController.swift
//  NetPictures
//
//  Created by Metalien on 2026/6/25.
//

import UIKit
import SnapKit
import KRProgressHUD
//import ProgressHUD

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let testButton = UIButton(type: .custom)
        testButton.setTitle("测试", for: .normal)
        testButton.setTitleColor(.black, for: .normal)
        testButton.addTarget(self, action: #selector(testButtonAction(sender:)), for: .touchUpInside)
        view.addSubview(testButton)
        testButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(120)
        }
        
//        HUDManager.shared.showLoading(nil)
        
//        ProgressHUD.animate(interaction: true)
    }
    
    @objc private func testButtonAction(sender: UIButton) {
        
//        sender.isSelected.toggle()
//        if sender.isSelected {
//            HUDManager.shared.showLoading("测试", interaction: true)
//        }
//        else {
//            HUDManager.shared.showText(getRandomToast())
//        }
//
//        ProgressHUD.animate()
        
//        HUDManager.shared.showText(getRandomToast())
        
        KRProgressHUD
            .set(maskType: .clear)
        KRProgressHUD.showMessage(getRandomToast())
//        KRProgressHUD.show()
        
        print("testButtonAction:")
    }
    
    private func getRandomToast() -> String {
        let toastArray = [
            "测试用",
            "123",
            "456",
            "789",
            "000",
            "1234567890",
            "嗯嗯嗯嗯嗯",
            "哈哈哈哈",
            "呵呵呵呵呵"
        ]
        return toastArray.randomElement() ?? "默认提示文案"
    }
}
