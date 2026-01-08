//
//  ViewController.swift
//  SimpleClock
//
//  Created by Metalien on 2026/1/8.
//

import UIKit

class ViewController: UIViewController {
    
    let countLabel = UILabel(frame: CGRectMake(0, 0, MacroScreen.currentBounds.width, MacroScreen.currentBounds.height/2.0))
    let leftButton = UIButton(frame: CGRectMake(0, MacroScreen.currentBounds.height/2.0, MacroScreen.currentBounds.width/2.0, MacroScreen.currentBounds.height/2.0))
    let rightButton = UIButton(frame: CGRectMake(MacroScreen.currentBounds.width/2.0, MacroScreen.currentBounds.height/2.0, MacroScreen.currentBounds.width/2.0, MacroScreen.currentBounds.height/2.0))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

