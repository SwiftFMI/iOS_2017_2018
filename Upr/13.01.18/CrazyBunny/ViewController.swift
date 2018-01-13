//
//  ViewController.swift
//  CrazyBunny
//
//  Created by Spas Bilyarski on 8.01.18.
//  Copyright © 2018 spasbilyarski. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var bunnyImageView: UIImageView!
    @IBOutlet weak var grassImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bunnyImageView.center = view.center
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Helpers
    
    func randomColor() -> UIColor {
        let redValue = CGFloat(arc4random_uniform(255)) / 255.0;
        let greenValue = CGFloat(arc4random_uniform(255)) / 255.0;
        let blueValue = CGFloat(arc4random_uniform(255)) / 255.0;
        
        return UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
    }
    
}

