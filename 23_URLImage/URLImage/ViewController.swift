//
//  ViewController.swift
//  URLImage
//
//  Created by Metalien on 2026/4/17.
//

import UIKit

class ViewController: UIViewController {
    
    let imageURL = "https://b0.bdstatic.com/ugc/personal_page_creator/68Hk7rhJv7Im1ltWO3X5sQe1c35c7959b6853b20c4424faef4c45a.jpg"
//    "https://b0.bdstatic.com/ugc/personal_page_creator/68Hk7rhJv7Im1ltWO3X5sQ02616486bbc26db1886ff98c292aa305.jpg"
//    "https://b0.bdstatic.com/ugc/personal_page_creator/68Hk7rhJv7Im1ltWO3X5sQcc007ea318715e75a5c0c40509f96cec.jpg"
    let titles = ["普通方式打开", "普通方式下载图片", "自定义方式下载图片", "带进度的下载方式"]
    var images = [UIImageView]()
    // 获取尺寸
    let width = ScreenSizeUtils.SCREEN_WIDTH
    let height = ScreenSizeUtils.SCREEN_HEIGHT

    // MARK: - Override
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let point = touches.first?.location(in: nil) {
            /*
             区间运算符：...闭区间，..<半闭区间
             */
            switch (point.x, point.y) {
            case (0...width/2, 0...height/2):
                loadImageEvent()
                print("左上")
            case (width/2...width, 0...height/2):
                downloadImageEvent()
                print("右上")
            case (0...width/2, height/2...height):
                backgroundDownloadImageEvent()
                print("左下")
            default:
                showLoadImageProgressEvent()
                print("右下")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 创建视图
        setupSubviews()
    }

    
    // MARK: - Private
    
    // 创建视图
    private func setupSubviews() {
        // 遍历
        for (index, (x, y)) in [(0, 0),(1, 0),(0, 1),(1, 1)].enumerated() {
            let imageView = bulidImageView(rect: CGRect(x: width/2*CGFloat(x),
                                                        y: height/2*CGFloat(y),
                                                        width: width/2,
                                                        height: height/2),
                                           tag: index,
                                           title: titles[index])
            images.append(imageView)
        }
    }

    // 创建图片
    private func bulidImageView(rect: CGRect, tag: Int, title: String) -> UIImageView {
        
        let tempImageView = UIImageView(frame: rect)
        tempImageView.contentMode = .scaleAspectFill
        tempImageView.backgroundColor = .white
        tempImageView.clipsToBounds = true
        tempImageView.tag = tag
        
        let tempLabel = UILabel(frame: tempImageView.bounds)
        tempLabel.textAlignment = .center
        tempLabel.textColor = .orange
        tempLabel.text = title
        tempImageView.addSubview(tempLabel)
        
        view.addSubview(tempImageView)
        
        return tempImageView
    }
    
    
    // MARK: - Event
    
    private func loadImageEvent() {
        guard let url = URL(string: imageURL) else {
            print("图片URL无效")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            // 1. 先判断有没有错误
            if let error = error {
                print("图片下载失败：\(error)")
                return
            }
            // 2. 判断 data 是否存在（不强行解包）
            guard let data = data, let image = UIImage(data: data) else {
                print("图片数据为空或格式错误")
                return
            }
            // 3. 主线程赋值
            DispatchQueue.main.async {
                self.images.first?.image = image
            }
        }.resume()
    }
    
    private func downloadImageEvent() {
        guard let url = URL(string: imageURL) else {
            print("图片URL无效")
            return
        }
        // 使用 downloadTask 下载图片到临时文件
        URLSession.shared.downloadTask(with: url) { location, response, error in
            // 1. 网络错误处理
            if let error = error {
                print("图片下载失败：\(error.localizedDescription)")
                return
            }
            // 2. 安全判断临时文件路径（绝不使用 !）
            guard let tempURL = location else {
                print("下载路径为空")
                return
            }
            // 3. 后台线程读取文件（不卡主线程）
            do {
                let imageData = try Data(contentsOf: tempURL)
                guard let image = UIImage(data: imageData) else {
                    print("图片数据格式错误")
                    return
                }
                // 4. 主线程安全赋值（防止数组越界）
                DispatchQueue.main.async {
                    guard self.images.count > 1 else {
                        print("images 数组没有第2个元素")
                        return
                    }
                    self.images[1].image = image
                }
            } catch {
                print("读取图片失败：\(error.localizedDescription)")
            }
        }.resume()
    }
    
    private func backgroundDownloadImageEvent() {
        guard let url = URL(string: imageURL) else {
            print("图片URL无效")
            return
        }
        URLSession(configuration: URLSessionConfiguration.default).downloadTask(with: url) { (location, response, error) in
            // 1. 网络错误处理
            if let error = error {
                print("图片下载失败：\(error.localizedDescription)")
                return
            }
            // 2. 安全判断临时文件路径（绝不使用 !）
            guard let tempURL = location else {
                print("下载路径为空")
                return
            }
            // 3. 后台线程读取文件（不卡主线程）
            do {
                let imageData = try Data(contentsOf: tempURL)
                guard let image = UIImage(data: imageData) else {
                    print("图片数据格式错误")
                    return
                }
                // 4. 主线程安全赋值（防止数组越界）
                DispatchQueue.main.async {
                    guard self.images.count > 1 else {
                        print("images 数组没有第2个元素")
                        return
                    }
                    self.images[2].image = image
                }
            } catch {
                print("读取图片失败：\(error.localizedDescription)")
            }
        }.resume()
    }
    
    private func showLoadImageProgressEvent() {
        guard let url = URL(string: imageURL) else {
            print("图片URL无效")
            return
        }
        URLSession(configuration: .background(withIdentifier: "backgroundDownload"), delegate: self, delegateQueue: nil).downloadTask(with: url).resume()
    }
    
}


extension ViewController: URLSessionDownloadDelegate {
    
    // MARK: - URLSessionDownloadDelegate
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        // 后台线程读取文件（不卡主线程）
        do {
            let imageData = try Data(contentsOf: location)
            guard let image = UIImage(data: imageData) else {
                print("图片数据格式错误")
                return
            }
            // 主线程安全赋值（防止数组越界）
            DispatchQueue.main.async {
                guard self.images.count > 1 else {
                    print("images 数组没有第2个元素")
                    return
                }
                self.images[3].image = image
            }
        } catch {
            print("读取图片失败：\(error.localizedDescription)")
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        if totalBytesExpectedToWrite > 0 {
            // 正常情况：有文件大小
            let progress = Double(totalBytesWritten) / Double(totalBytesExpectedToWrite)
            let percent = String(format: "%.1f%%", progress * 100)
            print("下载进度：\(percent)")
        } else {
            // 无文件大小：只打印已下载大小，不计算百分比
            print("已下载：\(ByteCountFormatter.string(fromByteCount: totalBytesWritten, countStyle: .file))")
        }
    }

    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
        print("从\(fileOffset)处恢复下载，一共\(expectedTotalBytes)")
    }
    
}

