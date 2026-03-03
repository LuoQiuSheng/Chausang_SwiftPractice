//
//  ViewController.swift
//  CurrentLocation
//
//  Created by Metalien on 2026/3/3.
//

import UIKit
import CoreLocation

/*
 使用定位的步骤：
 1. general -> Linked Frameworks and Libraries 导入 CoreLocation.framework 框架
 2. import CoreLocation
 3. 然后就可以开始使用了
 */

class ViewController: UIViewController {
    
    let locationButton = UIButton()
    let locationDescribeLabel = UILabel()
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

