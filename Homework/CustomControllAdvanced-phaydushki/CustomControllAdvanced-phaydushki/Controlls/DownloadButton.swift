//
//  DownloadButton.swift
//  CustomControllAdvanced-phaydushki
//
//  Created by Petko Haydushki on 24.11.17.
//  Copyright © 2017 Petko Haydushki. All rights reserved.
//

import UIKit

class DownloadButton: UIButton {

    var controllColor : UIColor = UIColor()
    
    var downloading = false
    var downloaded = false
    
    var circleLayer : CAShapeLayer = CAShapeLayer.init();
    var circlePath : UIBezierPath = UIBezierPath()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.initialize()
    }
    
    
    func initialize() -> Void {
        
        controllColor = UIColor.init(red: 26.0/255.0, green: 160.0/255.0, blue: 215.0/255.0, alpha: 1.0)
        
        let frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        
        circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width/2.0, y: frame.size.height / 2.0), radius: (frame.size.width - 10)/2, startAngle: -CGFloat.pi/2.0, endAngle: CGFloat.pi * 2.0 - CGFloat.pi/2.0, clockwise: true)
        
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = controllColor.cgColor
        circleLayer.lineWidth = 10.0;
        circleLayer.lineCap = kCALineCapRound
        
        self.layer.borderWidth = 2.0
        //26 160 215
        
        self.layer.borderColor = controllColor.cgColor
        self.layer.cornerRadius = self.frame.height/2.0
        self.layer.masksToBounds = true
        
        self.setTitle("Download!", for: UIControlState.normal)
        self.setTitleColor(controllColor, for: UIControlState.normal)
        
        self.addTarget(self, action: #selector(sel), for: UIControlEvents.touchUpInside)
    }
    
    @objc func sel() -> Void {
        
        self.titleLabel?.textAlignment = NSTextAlignment.center
        
        if (downloaded == true)
        {
            self.setTitle("Download!", for: UIControlState.normal)
            downloaded = false
            downloading = false
        }
        else
        {
            if (downloading == true)
            {
                self.setTitle("Download!", for: UIControlState.normal)
                
                self.circleLayer.removeAnimation(forKey: "animateCircle")
                self.circleLayer.removeFromSuperlayer()
                downloading = false
            }
            else
            {
                self.setTitle("✖", for: UIControlState.normal)

                downloading = true
                CATransaction.begin()
                
                let animation = CABasicAnimation(keyPath: "strokeEnd")
                animation.duration = 4.0
                animation.fromValue = 0
                animation.toValue = 1
                animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                circleLayer.strokeEnd = 1.0
                CATransaction.setCompletionBlock {
                    if (self.downloading)
                    {
                        self.setTitle("Open", for: UIControlState.normal)
                    }
                    self.circleLayer.removeFromSuperlayer()
                    
                    self.downloading = false
                    self.downloaded = true
                }
                // Do the actual animation
                circleLayer.add(animation, forKey: "animateCircle")
                CATransaction.commit()
                self.layer.addSublayer(circleLayer);
            }
        }
        
        
        
    }
    
    
}
