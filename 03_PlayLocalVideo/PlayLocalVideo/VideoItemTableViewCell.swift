//
//  VideoItemTableViewCell.swift
//  PlayLocalVideo
//
//  Created by Metalien on 2026/2/2.
//

import UIKit

struct VideoModel {
    let image: String
    let title: String
    let source: String
}

class VideoItemTableViewCell: UITableViewCell {
    
    var videoImageView: UIImageView?
    var videoPlayerImageView: UIImageView?
    var videoTitleLabel: UILabel?
    var videoSourceLabel: UILabel?
    
    // MARK: Override

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // 加载子视图
        loadSubviews()
    }
    
    // 核心：重写layoutSubviews，每次尺寸变化时更新frame
    override func layoutSubviews() {
        super.layoutSubviews() // 必须调用父类方法，保证系统布局正常执行
        guard let videoIV = videoImageView,
              let playerIV = videoPlayerImageView,
              let titleLbl = videoTitleLabel,
              let sourceLbl = videoSourceLabel else { return }
        
        // 用最新的contentView.bounds设置frame，解决尺寸不准确问题
        videoIV.frame = contentView.bounds
        playerIV.frame = contentView.bounds
        titleLbl.frame = CGRect(x: 0, y: contentView.bounds.height - 50, width: contentView.bounds.width, height: 30)
        sourceLbl.frame = CGRect(x: 0, y: contentView.bounds.height - 20, width: contentView.bounds.width, height: 20)
    }
    
    // MARK: Private
    
    private func loadSubviews() {
        
        // 视频封面
        videoImageView = UIImageView()
        videoImageView?.contentMode = .scaleAspectFill
        contentView.addSubview(videoImageView!)
        
        // 播放按钮
        videoPlayerImageView = UIImageView()
        videoPlayerImageView?.contentMode = .center
        videoPlayerImageView?.image = UIImage(named: "playBtn")
        contentView.addSubview(videoPlayerImageView!)
        
        // 标题
        videoTitleLabel = UILabel()
        videoTitleLabel?.textColor = .white
        videoTitleLabel?.textAlignment = .center
        videoTitleLabel?.font = UIFont(name: "Zapfino", size: 24)
        contentView.addSubview(videoTitleLabel!)
        
        // 来源
        videoSourceLabel = UILabel()
        videoSourceLabel?.textColor = .gray
        videoSourceLabel?.textAlignment = .center
        videoSourceLabel?.font = UIFont(name: "Avenir Next", size: 14)
        contentView.addSubview(videoSourceLabel!)
    }
    
    // MARK: Public
    
    public func setModel(model: VideoModel) {
        videoImageView?.image = UIImage(named: model.image)
        videoTitleLabel?.text = model.title
        videoSourceLabel?.text = model.source
    }
    
    
    // MARK: Other
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
