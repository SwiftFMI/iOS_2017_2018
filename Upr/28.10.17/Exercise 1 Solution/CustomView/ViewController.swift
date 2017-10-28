//
//  ViewController.swift
//  CustomView
//
//  Created by Valentin Varbanov on 28.10.17.
//  Copyright © 2017 Valentin Varbanov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var coloredView: CustomView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        coloredView.choises = [
            "Purple": UIColor.purple,
            "Brown": UIColor.brown,
            "Gray": UIColor.gray
        ]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

