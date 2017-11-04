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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Добавяме заоблени ръбове
        controlCenterView.layer.cornerRadius = 20.0
        
        // Премахваме помощният фонов цвят на controlCenterView
        controlCenterView.backgroundColor = UIColor.clear
        
        // Добавяме замъглен ефект
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)

        blurEffectView.frame = controlCenterView.bounds
        
        // По този начин се уверяваме, че замъгленият ефект ще бъде добавен под всички останали subview-та на controlCenterView
        controlCenterView.insertSubview(blurEffectView, at: 0)
    }

    @IBAction func iconAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
}

