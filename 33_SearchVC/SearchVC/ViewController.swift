//
//  ViewController.swift
//  SearchVC
//
//  Created by Metalien on 2026/6/15.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    
    var mainTableView: UITableView!
    var dataSource = [ProvinceModel]()
    let reuseIdentifier = String(describing: UITableViewCell.self)
    
    var searchController: UISearchController!
    var searchResultTableViewController: SearchResultTableViewController!
    
    var isSearching: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置标题
        title = "所有省份"
        // 获取数据源
        getPlistData()
        // 创建视图
        setupSubviews()
    }
    
    // 获取数据源
    private func getPlistData() {
        let dictionary = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "Province", ofType: "plist")!)
        dictionary?.enumerateKeysAndObjects { key, value, roolback in
            let values = value as! NSDictionary
            var citys = [City]()
            for tempKey in values.allKeys {
                let city = City(name: tempKey as! String, alias: values[tempKey] as! String)
                citys.append(city)
            }
            let province = ProvinceModel(name: key as! String, pinyin: transformToPinyin(key as! String), citys: citys)
            dataSource.append(province)
        }
    }

    // 创建视图
    private func setupSubviews() {
        
        // 初始化 TableView
        mainTableView = UITableView(frame: CGRectZero, style: .plain)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.separatorStyle = .none
        mainTableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(mainTableView)
        mainTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // TableViewController
        searchResultTableViewController = SearchResultTableViewController(style: .plain)
        searchResultTableViewController.tableView.delegate = self // 将搜索结果的点击和本页点击绑定，点击效果一样
        
        // SearchController
        searchController = UISearchController(searchResultsController: searchResultTableViewController)
        searchController.obscuresBackgroundDuringPresentation = true // 开始搜索时，是否关闭当前VC的控制功能，默认是true，为true，当开始搜索时，是无法控制当前VC的，false时，可以控制
        searchController.searchResultsUpdater = self // 设置代理
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        searchController.searchBar.keyboardType = .default
        searchController.searchBar.placeholder = "可以输入拼音首字母进行搜索，比如：广东 GD"
        
        // 关联
        mainTableView.tableHeaderView = searchController.searchBar
        
        // 限定搜索遮罩只在当前VC内生效
        definesPresentationContext = true
    }
    
    // 将数据转换成拼音
    private func transformToPinyin(_ objectString: String) -> String {
        let pinyin = NSMutableString(string: objectString)
        let transformPinyin = NSMutableString()
        // 转成拼音
        CFStringTransform(pinyin as CFMutableString, nil, kCFStringTransformMandarinLatin, false)
        // 去掉声母
        CFStringTransform(pinyin as CFMutableString, nil, kCFStringTransformStripDiacritics, false)
        // 获得每个汉字拼音首个大写字母
        let tempArray = pinyin.components(separatedBy: " ")
        for tempString in tempArray {
            if !tempString.isEmpty {
                // 使用切片语法 [..<index]
                let index = tempString.index(after: tempString.startIndex)
                transformPinyin.append(String(tempString[..<index]))
            }
        }
        return transformPinyin as String
    }
    
    // 选中处理
    private func didSelectRowAt(_ indexPath: IndexPath) {
        let showVC = ShowProvinceDetailViewController()
        if isSearching {
            showVC.province = searchResultTableViewController.dataSource[indexPath.row]
        } else {
            showVC.province = dataSource[indexPath.row]
        }
        self.navigationController?.pushViewController(showVC, animated: true)
    }
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // 选中处理
        didSelectRowAt(indexPath)
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = dataSource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = data.name
        cell.textLabel?.textColor = .black
        return cell
    }
}


extension ViewController: UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating {
    
    // MARK: - UISearchBarDelegate
    
    // 搜索取消按钮被点击
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    // MARK: - UISearchControllerDelegate
    
    // 推出搜索控制器
    func presentSearchController(_ searchController: UISearchController) {
    }
    
    // 将要出现
    func willPresentSearchController(_ searchController: UISearchController) {
    }
    
    // 已经出现
    func didPresentSearchController(_ searchController: UISearchController) {
        isSearching = true
    }
    
    // 将要消失
    func willDismissSearchController(_ searchController: UISearchController) {
    }
    
    // 已经消失
    func didDismissSearchController(_ searchController: UISearchController) {
        isSearching = false
    }
    
    // MARK: - UISearchResultsUpdating
    
    // 更新搜索结果
    func updateSearchResults(for searchController: UISearchController) {
        
        let inputString = searchController.searchBar.text!
        print("输入：\(inputString)")
        let result = dataSource.filter({$0.pinyin.contains(inputString.lowercased()) ||
            $0.name.contains(inputString)})
        print("搜索结果：\(result.count)")
        // 重置数据并刷新
        searchResultTableViewController.dataSource = result
        searchResultTableViewController.tableView.reloadData()
        /*
         Swift数组很重要的高阶函数：
         map:将每个元素通过某个方法进行转换成新的数组
         例子：stringsArray = moneyArray.map({"($0)?"})
         stringsArray = moneyArray.map({money in "(money)?"})
         filter:选择满足某些条件的元素组成新的数组
         例子：filteredArray = moneyArray.filter({$0 > 30})
         reduce:把数组元组组合计算为一个值
         例子：sum = moneyArray.reduce(0,{$0 + $1})初始值0，元素相加
         上面简写：sum = moneyArray.reduce(0,+)
         */
    }
}

