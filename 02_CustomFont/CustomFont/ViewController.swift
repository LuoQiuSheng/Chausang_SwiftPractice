//
//  ViewController.swift
//  CustomFont
//
//  Created by Metalien on 2026/1/14.
//

import UIKit

/*
 导入字体步骤：
 1.下载ttf文件，加入项目中
 2.在info.plist中，添加一个字段：Fonts provided by application
 3.再添加item，值写入字体的名字
 4.然后就可以通过名字使用了
 */

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var screenWidth: CGFloat {
        MacroScreen.width(in: view)
    }
    var screenHeight: CGFloat {
        MacroScreen.height(in: view)
    }
    
    var mainTableView : UITableView?
    var changeFontButton : UIButton?
    let dataSource = ["修改字体_1", "修改字体_2", "修改字体_3", "修改字体_4"]
    let fontNames = ["MFTongXin_Noncommercial-Regular", "MFJinHei_Noncommercial-Regular", "MFZhiHei_Noncommercial-Regular", "Heiti SC"]
    var fontIndex = 0
    let reuseIdentifier = "CustomFontCell"
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 设置背景色
        view.backgroundColor = .white
        // 加载视图
        loadSubviews()
    }


    // MARK: Private
    
    /// 加载视图
    private func loadSubviews() {
        
        // Table View
        mainTableView = UITableView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight*2.0/3.0), style: .plain)
        mainTableView?.delegate = self
        mainTableView?.dataSource = self
        mainTableView?.backgroundColor = .black
        view.addSubview(mainTableView!)
        
        // UIButton
        changeFontButton = UIButton(type: .custom)
        changeFontButton?.frame = CGRect(x: 0, y: screenHeight*2.0/3.0, width: screenWidth, height: screenHeight*1.0/3.0)
        changeFontButton?.setTitle("改变字体", for: .normal)
        changeFontButton?.backgroundColor = .orange
        changeFontButton?.addAction(
            UIAction { [weak self] action in
                // 通过 action.sender 获取按钮，类型是 UIButton
                if let button = action.sender as? UIButton {
                    self?.changeFontButtonAction(button)
                }
            },
            for: .touchUpInside
        )
        view.addSubview(changeFontButton!)
    }
    
    
    // MARK: Action
    
    private func changeFontButtonAction(_ sender: UIButton) {
        fontIndex = (fontIndex+1)%fontNames.count
        mainTableView?.reloadData()
    }
    
    
    // MARK: UITableViewDelegate & UITableViewDataSource
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) ?? UITableViewCell(style: .subtitle, reuseIdentifier: reuseIdentifier)
        cell.textLabel?.text = dataSource[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont(name: fontNames[fontIndex], size: 30)
        cell.backgroundColor = .black
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 取消点击效果
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath)
        // 链式调用，最后得到一个可选的string,！强制解包出来
        let str = "当前字体是："+(cell?.textLabel?.font.fontName)!
        print(str)
    }
    
}

