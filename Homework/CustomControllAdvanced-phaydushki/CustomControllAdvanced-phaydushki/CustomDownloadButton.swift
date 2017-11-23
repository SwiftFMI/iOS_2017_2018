//
//  CustomDownloadButton.swift
//  CustomControllAdvanced-phaydushki
//
//  Created by Petko Haydushki on 14.11.17.
//  Copyright © 2017 Petko Haydushki. All rights reserved.
//

import UIKit

class CustomDownloadButton: UIView {
    
    var circleLayer : CAShapeLayer = CAShapeLayer.init();
    var circlePath : UIBezierPath = UIBezierPath()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        CATransaction.begin()
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 4.0
        animation.fromValue = 0
        animation.toValue = 1
        let frame = CGRect.init(x: 100, y: 40, width: 100, height: 100)
         circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width - 10)/2, startAngle: 0.0, endAngle: CGFloat(Double.pi * 2.0), clockwise: true)
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor.red.cgColor
        circleLayer.lineWidth = 50.0;
        

        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        circleLayer.strokeEnd = 1.0
        CATransaction.setCompletionBlock {
            print("animation complete")
        }
        // Do the actual animation
        circleLayer.add(animation, forKey: "animateCircle")
        CATransaction.commit()
        self.layer.addSublayer(circleLayer);
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
}
