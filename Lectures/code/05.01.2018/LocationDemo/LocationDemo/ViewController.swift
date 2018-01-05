//
//  ViewController.swift
//  LocationDemo
//
//  Created by Emil Atanasov on 5.01.18.
//  Copyright © 2018 SwiftFMI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    //UIRequiredDeviceCapabilities в Info.plist се използва за да се определи дали дадено устройство има съответния хардуер и дали приложението ще работи location-services или gps
    
    //Ако приложението може да работи и без тези изисквания, тогава не е нужно да добавяте
    //тези изсквания, понеже броя на поддържаните устройства ще е по-малък.
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

