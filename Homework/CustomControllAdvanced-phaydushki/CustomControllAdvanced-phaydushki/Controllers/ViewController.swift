//
//  ViewController.swift
//  CustomControllAdvanced-phaydushki
//
//  Created by Petko Haydushki on 11.11.17.
//  Copyright © 2017 Petko Haydushki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var meterCircularView: MeterCircularView!
    
    @IBOutlet weak var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func valueChanged(_ sender: Any) {
        self.meterCircularView.valueChanged(value: Double(self.slider.value))
    }
    
}

