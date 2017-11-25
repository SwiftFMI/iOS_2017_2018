//
//  DashedPercentageMeter.swift
//  CustomControllAdvanced-phaydushki
//
//  Created by Petko Haydushki on 25.11.17.
//  Copyright © 2017 Petko Haydushki. All rights reserved.
//

import UIKit

class DashedPercentageMeter: UIView {
    
    var cicrleLayer : CAShapeLayer = CAShapeLayer.init()
    var blackCicrleLayer : CAShapeLayer = CAShapeLayer.init()
    var cicrlePath : UIBezierPath = UIBezierPath()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
    }
    
    override func draw(_ rect: CGRect)
    {
        let lineWidth : CGFloat = 26.0
        self.cicrlePath.addArc(withCenter: CGPoint(x: rect.size.width/2.0, y: rect.height/2.0), radius:self.frame.size.width/2.0 - lineWidth/2.0, startAngle: 0.0*CGFloat.pi, endAngle: 2.0*CGFloat.pi, clockwise: true)
        
        let one : CGFloat = 30
        let two : CGFloat = 40
        let pattern = [one,two]
        
        self.cicrlePath.setLineDash(pattern, count: 30, phase: 2.0)
        
        
        self.cicrleLayer.path = self.cicrlePath.cgPath
        self.cicrleLayer.fillColor = UIColor.clear.cgColor
        self.cicrleLayer.strokeColor = UIColor.cyan.cgColor
        self.cicrleLayer.lineWidth = lineWidth
        
        self.blackCicrleLayer.path = self.cicrlePath.cgPath
        self.blackCicrleLayer.fillColor = UIColor.clear.cgColor
        self.blackCicrleLayer.strokeColor = UIColor.black.cgColor
        self.blackCicrleLayer.lineWidth = 1.0
        
        self.layer.addSublayer(self.cicrleLayer)
        self.layer.addSublayer(self.blackCicrleLayer)
    }
    
}
