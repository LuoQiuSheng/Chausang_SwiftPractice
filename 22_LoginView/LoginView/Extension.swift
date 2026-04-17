//
//  Extension.swift
//  LoginView
//
//  Created by Metalien on 2026/4/17.
//

import UIKit

extension UITextField {
    
    func setupTextField(placeholer: String?, keyboardType: UIKeyboardType, text: String?) {
        
        self.placeholder = placeholer
        self.keyboardType = keyboardType
        self.text = text
        
        layer.cornerRadius = 5
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 1
        
        textAlignment = .center
        clearButtonMode = .whileEditing
    }
    
}


extension UIButton {
    
    func setupButton(title: String?, bgColor: UIColor) {
        setTitle(title, for: .normal)
        setTitleColor(backgroundColor, for: .normal)
        
        backgroundColor = bgColor
        
        layer.cornerRadius = 20
    }
}


extension Date {
    
    static func getCurrentTime() -> String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss:SSSS"
        return format.string(from: date)
    }
}

/*
 调试打印输出，发布取消
 #file - 文件名
 #function - 函数名
 #line - 行号
 */
func DLog(_ message: Any) {
#if DEBUG
    print("\(Date.getCurrentTime()) | \(#line) | \(URL(fileURLWithPath: #file).lastPathComponent) || \(message)")
#endif
}
