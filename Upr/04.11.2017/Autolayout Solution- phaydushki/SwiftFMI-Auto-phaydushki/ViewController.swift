//
//  ViewController.swift
//  SwiftFMI-Auto
//
//  Created by Spas Bilyarski on 3.11.17.
//  Copyright © 2017 spasbilyarski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var controlCenterView: UIView!
    var blurEffectView = UIVisualEffectView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Добавяме заоблени ръбове
        controlCenterView.layer.cornerRadius = 20.0
        
        // Премахваме помощният фонов цвят на controlCenterView
        controlCenterView.backgroundColor = UIColor.clear
        
        // Добавяме замъглен ефект
        let blurEffect = UIBlurEffect(style: .light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)

        blurEffectView.frame = controlCenterView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        // По този начин се уверяваме, че замъгленият ефект ще бъде добавен под всички останали subview-та на controlCenterView
        controlCenterView.insertSubview(blurEffectView, at: 0)
//        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }

    @objc func rotated() -> Void {
//        blurEffectView.frame = controlCenterView.bounds
//        blurEffectView.autoresizingMask =
    }
    
    @IBAction func iconAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
}

