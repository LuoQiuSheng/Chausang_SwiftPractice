//
//  ViewController.swift
//  CurrentLocation
//
//  Created by Metalien on 2026/3/3.
//

import UIKit
import CoreLocation
import SnapKit

/*
 使用定位的步骤：
 1. general -> Linked Frameworks and Libraries 导入 CoreLocation.framework 框架
 2. import CoreLocation
 3. 然后就可以开始使用了
 */

class ViewController: UIViewController {
    
    let backgroundImageView = UIImageView(image: UIImage(named: "bg"))
    let backgroundVisual = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    let locationDescribeLabel = UILabel()
    let locationButton = UIButton()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 背景图片
        backgroundImageView.contentMode = .scaleAspectFill
        
        // 定位管理器
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // 精准度
//        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization() // 发送开启定位的请求
        
        // 地址显示文本
        locationDescribeLabel.text = "未定位"
        locationDescribeLabel.textColor = .white
        locationDescribeLabel.textAlignment = .center
        locationDescribeLabel.font = UIFont.systemFont(ofSize: 14)
        locationDescribeLabel.numberOfLines = 0
        
        // 定位按钮
        locationButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        locationButton.setTitle("点击定位", for: .normal)
        locationButton.setTitleColor(.white, for: .normal)
        locationButton.setBackgroundImage(UIImage(named: "Find my location"), for: .normal)
        locationButton.addTarget(self, action: #selector(locationButtonAction(sender:)), for: .touchUpInside)
        
        // 创建视图
        setupSubviews();
    }

    /// 创建视图
    private func setupSubviews() {
        
        // 添加视图
        view.addSubview(backgroundImageView)
        view.addSubview(backgroundVisual)
        view.addSubview(locationDescribeLabel)
        view.addSubview(locationButton)
        
        // 设置约束
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        backgroundVisual.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        locationDescribeLabel.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.left.right.equalTo(view).inset(30)
        }
        locationButton.snp.makeConstraints { make in
            make.top.equalTo(locationDescribeLabel.snp.bottom).offset(12)
            make.left.right.equalTo(view).inset(30)
            make.height.equalTo(80)
        }
    }
    
    // MARK: Action
    
    @objc func locationButtonAction(sender: UIButton) {
        // 判断定位服务是否开启
        if locationManager.authorizationStatus == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        }
        else {
            locationManager.startUpdatingLocation()
        }
    }

}


extension ViewController: CLLocationManagerDelegate {
    
    /// 定位成功
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let newLocal = locations.first {
            CLGeocoder().reverseGeocodeLocation(newLocal, completionHandler: { (pms, err) in
                if (pms?.last?.location?.coordinate) != nil {
                    manager.stopUpdatingLocation() // 停止定位，节省电量，只获取一次定位
                    // 取得第一个地标，地标中存储了详细的地址信息，注意：一个地名可能搜索出多个地址
                    let placemark:CLPlacemark = (pms?.last)!
                    print(placemark)
                    let name: String? = placemark.name;// 地名
                    let thoroughfare: String? = placemark.thoroughfare;// 街道
                    let subThoroughfare: String? = placemark.subThoroughfare; // 街道相关信息，例如门牌等
                    let locality: String? = placemark.locality; // 城市
                    let country: String? = placemark.country; // 国家
                    let components = [country, locality, name, thoroughfare, subThoroughfare]
                        .compactMap({ $0 })
                        .filter({ !$0.isEmpty })
                        .reduce(into: [String]()) { $0.contains($1) ? () : $0.append($1) }
                    self.locationDescribeLabel.text = components.joined(separator: " ")
                    // 别的含义
                    // let location = placemark.location; // 位置
                    // let addressDic = placemark.addressDictionary; // 详细地址信息字典,包含以下部分信息
                    // let subLocality = placemark.subLocality; // 城市相关信息，例如标志性建筑
                    // let administrativeArea = placemark.administrativeArea; // 州
                    // let subAdministrativeArea = placemark.subAdministrativeArea; // 其他行政区域信息
                    // let postalCode = placemark.postalCode; // 邮编
                    // let ISOcountryCode = placemark.ISOcountryCode; // 国家编码
                    // let region = placemark.region; // 区域
                    // let inlandWater = placemark.inlandWater; // 水源、湖泊
                    // let ocean = placemark.ocean; // 海洋
                    // let areasOfInterest = placemark.areasOfInterest; //关联的或利益相关的地标
                    // self.locationDescribeLabel.text = String(country ?? "")+String(locality ?? "")+String(name ?? "")+String(thoroughfare ?? "")+String(subThoroughfare ?? "")
                }
            })
        }
    }
    
    /// 定位失败
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationDescribeLabel.text = "ERROR:"+error.localizedDescription
        // 若 text 为 nil，打印「暂无文本」；有值则打印纯文本
        print("\(locationDescribeLabel.text ?? "暂无文本")")
    }
    
}

