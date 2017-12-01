//
//  GenericViewController.swift
//  CustomControllAdvanced-phaydushki
//
//  Created by Petko Haydushki on 24.11.17.
//  Copyright © 2017 Petko Haydushki. All rights reserved.
//

import UIKit

class GenericViewController: UIViewController {
    
    var item : String = String()
    
    lazy var slider : UISlider = UISlider()
    lazy var percentageMeter : DashedPercentageMeter = DashedPercentageMeter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let frame = self.view.frame
        var controllWidth : CGFloat = 100.0
        
        switch item {
        case "Percetage meter" :
            title = item
            controllWidth = 200.0
            percentageMeter = DashedPercentageMeter.init(frame: CGRect.init(x: frame.size.width/2.0 - controllWidth/2.0, y: frame.size.height/2.0 - controllWidth/2.0, width: controllWidth, height: controllWidth))
            view.backgroundColor = UIColor.black
            
            slider = UISlider.init(frame: CGRect.init(x: frame.size.width/2.0 - controllWidth/2.0, y: frame.size.height/2.0 + controllWidth, width: controllWidth, height: 40))
            self.view.addSubview(slider)
            slider.addTarget(self, action: #selector(slideValueChanged), for: UIControlEvents.valueChanged)
            self.view.addSubview(percentageMeter)
        case "Rings" :
            title = item
            controllWidth = 240.0

            view.backgroundColor = UIColor.black

            let ringView : Rings = Rings.init(frame: CGRect.init(x: frame.size.width/2.0 - controllWidth/2.0, y: frame.size.height/2.0 - controllWidth/2.0, width: controllWidth, height: controllWidth))
            
            self.view.addSubview(ringView)
            
        case "Download Button" :
            title = item
                 
            let downloadButton : DownloadButton = DownloadButton.init(frame: CGRect.init(x: frame.size.width/2.0 - controllWidth/2.0, y: frame.size.height/2.0 - controllWidth/2.0, width: controllWidth, height: controllWidth))

            self.view.addSubview(downloadButton)

        default:
            title = "Empty"
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func slideValueChanged() -> Void {
        
        percentageMeter.updatePercentage(value: CGFloat(slider.value))
    }

}
