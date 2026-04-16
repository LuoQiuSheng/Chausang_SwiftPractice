//
//  ViewController.swift
//  MusicPlayer
//
//  Created by Metalien on 2026/4/14.
//

import UIKit
import SnapKit
import AVFoundation

class ViewController: UIViewController {
    
    // 表单控件
    let mainTableView = UITableView(frame: CGRectZero, style: .plain)
    // 复用标识
    let reuseIdentifier = "MusicCellReuseIdentifier"
    // 数据源
    let dataSource = ["成都", "童话镇"]
    // 音乐路径
    let musicPath = Bundle.main.resourcePath
//    let musicPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first?.appending("/music")
    // 音乐播放器
    var musicPlayer: AVAudioPlayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 创建视图
        setupSubviews()
    }


    // 创建视图
    private func setupSubviews() {
        
        // UITableView
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.showsVerticalScrollIndicator = false
        mainTableView.showsHorizontalScrollIndicator = false
        mainTableView.tableFooterView = UIView()
        
        // 新增视图
        view.addSubview(mainTableView)
        
        // 设置约束
        mainTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // 播放音乐
    private func playMusic(path: String) {
        if musicPlayer != nil {
            musicPlayer?.stop()
            musicPlayer = nil
        }
        do {
            try musicPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            musicPlayer?.numberOfLoops = -1 // 循环次数
            musicPlayer?.delegate = self
            musicPlayer?.play()
            //可以通过musicPlayer的属性获得歌曲的信息，包括长度，通道等信息
            print("歌曲长度：\((musicPlayer?.duration)!)")
        } catch let error as NSError {
            print("播放失败：\(error.localizedDescription)")
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource, AVAudioPlayerDelegate {
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) ?? UITableViewCell(style: .default, reuseIdentifier: reuseIdentifier)
        cell.textLabel?.text = dataSource[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = .orange
        cell.textLabel?.font = UIFont.systemFont(ofSize: 30)
        return cell
    }
    
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // 拼接 文件名 + .m4r（必须加后缀！）
        let musicName = dataSource[indexPath.row] + ".m4r"
        // 安全获取路径
        guard let path = Bundle.main.path(forResource: musicName, ofType: nil) else {
            print("找不到音频文件：\(musicName)")
            return
        }
        // 播放
        playMusic(path: path)
    }
    
    
    // MARK: AVAudioPlayerDelegate
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        musicPlayer = nil
    }
}



/*
 沙盒文件目录：
 AppName.app:应用程序本身数据，只读。  Bundle.main.path(forResource: <#T##String?#>, ofType: <#T##String?#>)
 Documents:会被itunes备份，应用程序产生的数据，不可再生的数据放在这里
 Inbox:该目录可被外部应用程序访问，只读，需要自己创建
 Library:
 Caches:应用程序启动过程需要的信息，不会被备份，存放可再生的数据
 Preferences:偏好设置，会被itunes备份
 tmp:临时数据存放，会自动被删除
 */
