//
//  ViewController.swift
//  PlayLocalVideo
//
//  Created by Metalien on 2026/2/2.
//

import UIKit
import AVKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var mainTableView: UITableView?
    var playViewController: AVPlayerViewController?
    var playView: AVPlayer?
    var dataSource: NSMutableArray?
    let reuseIdentifier = "VideoCellReuseIdentifier"
    
    // MARK: Override
    
    /// 隐藏状态栏
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 视图颜色
        view.backgroundColor = .black
        // 布局视图
        loadSubviews()
    }


    // MARK: Private
    
    /// 布局视图
    private func loadSubviews() {

        // 初始化数据
        dataSource = NSMutableArray(array: [
            VideoModel(image: "videoScreenshot01", title: "Introduce 3DS Mario", source: "Youtube - 06:32"),
            VideoModel(image: "videoScreenshot02", title: "Emoji Among Us", source: "Vimeo - 3:34"),
            VideoModel(image: "videoScreenshot03", title: "Seals Documentary", source: "Vine - 00:06"),
            VideoModel(image: "videoScreenshot04", title: "Adventure Time", source: "Youtube - 02:39"),
            VideoModel(image: "videoScreenshot05", title: "Facebook HQ", source: "Facebook - 10:20"),
            VideoModel(image: "videoScreenshot06", title: "Lijiang Lugu Lake", source: "Allen - 20:30")
        ])
        
        // 创建视图
        mainTableView = UITableView(frame: view.bounds, style: .plain)
        mainTableView?.backgroundColor = .black
        mainTableView?.delegate = self
        mainTableView?.dataSource = self
        mainTableView?.register(VideoItemTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
//        mainTableView?.register(VideoItemAutoLayoutTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(mainTableView!)
    }
    
    /// 播放视频
    private func playVideo(indexPath: NSIndexPath) {
        let path = Bundle.main.path(forResource: "emoji zone", ofType: "mp4")
        if path == nil {
            print("没有该文件！")
            return
        }
        playView = AVPlayer(url: URL(fileURLWithPath: path!))
        playViewController = AVPlayerViewController()
        playViewController?.player = playView
        self.present(playViewController!, animated: true) {
            self.playView?.play()
        }
    }
    
    
    // MARK: UITableViewDelegate & UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource!.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height/3.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*
         !强制解析值，解析前一定确保可选是有值的
         类型转换：
            as?:返回一个向下转型的类型的可选值
            as!:强制转型，并且解包
            is:检查能够向下转化成指定类型
            as:向上转换成超类
         当不确定是否可以转成功时，用as?，确定时，用as!
        */
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! VideoItemTableViewCell
        cell.setModel(model: dataSource![indexPath.row] as! VideoModel)
        return cell
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! VideoItemAutoLayoutTableViewCell
//        cell.setModel(model: dataSource![indexPath.row] as! VideoModel)
//        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        playVideo(indexPath: indexPath as NSIndexPath)
    }
}

