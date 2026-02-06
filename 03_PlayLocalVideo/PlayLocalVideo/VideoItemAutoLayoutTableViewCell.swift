//
//  VideoItemAutoLayoutTableViewCell.swift
//  PlayLocalVideo
//
//  Created by Metalien on 2026/2/2.
//

import UIKit

//struct VideoModel {
//    let image: String
//    let title: String
//    let source: String
//}

class VideoItemAutoLayoutTableViewCell: UITableViewCell {
    
    // MARK: - 复用优化（可选，解决复用闪烁问题）
    override func prepareForReuse() {
        super.prepareForReuse()
        videoImageView.image = nil
        videoTitleLabel.text = nil
        videoSourceLabel.text = nil
    }
    
    // MARK: - 初始化
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews() // 仅添加子视图，不设置布局
        setupNativeConstraints() // 单独设置原生Auto Layout约束，代码更清晰
    }
    
    // MARK: - 子视图添加
    private func setupSubviews() {
        // 所有子视图必须添加到contentView（Cell的官方容器，自动适配内边距/选中样式）
        contentView.addSubview(videoImageView)
        contentView.addSubview(videoPlayerImageView)
        contentView.addSubview(videoTitleLabel)
        contentView.addSubview(videoSourceLabel)
    }
    
    // MARK: - 原生Auto Layout 约束设置（核心）
    private func setupNativeConstraints() {
        // 批量激活约束：性能优于单独激活，代码更简洁
        NSLayoutConstraint.activate([
            // 1. 视频封面：铺满整个contentView（上下左右全对齐）
            videoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            videoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            videoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            videoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            // 2. 播放按钮：居中显示，固定60x60尺寸（与原布局逻辑一致）
            videoPlayerImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            videoPlayerImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            videoPlayerImageView.widthAnchor.constraint(equalToConstant: 60),
            videoPlayerImageView.heightAnchor.constraint(equalToConstant: 60),
            
            // 3. 标题标签：距离底部50pt，左右铺满，高度30pt
            videoTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            videoTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            videoTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50),
            videoTitleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            // 4. 来源标签：距离底部20pt，左右铺满，高度20pt
            videoSourceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            videoSourceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            videoSourceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            videoSourceLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    // MARK: - 数据绑定（与原逻辑一致，无修改）
    public func setModel(model: VideoModel) {
        videoImageView.image = UIImage(named: model.image)
        videoTitleLabel.text = model.title
        videoSourceLabel.text = model.source
    }
    
    // 1. 懒加载子视图：替代可选型(?)，避免强制解包(!)，初始化更安全
    // 视频封面图
    private lazy var videoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true // 关键：裁剪超出边界内容，避免封面变形
        iv.translatesAutoresizingMaskIntoConstraints = false // 核心：关闭系统自动约束，开启自定义Auto Layout
        return iv
    }()
    
    // 播放按钮
    private lazy var videoPlayerImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "playBtn"))
        iv.contentMode = .center
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    // 视频标题
    private lazy var videoTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Zapfino", size: 24) ?? UIFont.systemFont(ofSize: 24, weight: .bold) // 字体容错
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 视频来源
    private lazy var videoSourceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir Next", size: 14) ?? UIFont.systemFont(ofSize: 14) // 字体容错
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
