//
//  Rings.swift
//  CustomControllAdvanced-phaydushki
//
//  Created by Petko Haydushki on 25.11.17.
//  Copyright © 2017 Petko Haydushki. All rights reserved.
//

import UIKit

class Rings: UIView {

    var firstDashLayer : CAShapeLayer = CAShapeLayer.init();
    var firstDashPath : UIBezierPath = UIBezierPath()
    
    var secondDashLayer : CAShapeLayer = CAShapeLayer.init();
    var secondDashPath : UIBezierPath = UIBezierPath()
    
    var thirdDashLayer : CAShapeLayer = CAShapeLayer.init();
    var thirdDashPath : UIBezierPath = UIBezierPath()
    
    var fourthDashLayer : CAShapeLayer = CAShapeLayer.init();
    var fourthDashPath : UIBezierPath = UIBezierPath()
    
    var fifthDashLayer : CAShapeLayer = CAShapeLayer.init();
    var fifthDashPath : UIBezierPath = UIBezierPath()
    
    var hackDashLayer : CAShapeLayer = CAShapeLayer.init();
    var hackDashPath : UIBezierPath = UIBezierPath()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        
        let frameWidth = frame.size.width
        let frameHeight = frame.size.height
        
        let arrowWidth : CGFloat = 30.0
        
        let arrowCenter = CGPoint(x: (frameWidth / 2.0 ), y:frameHeight / 2.0)
        
        self.layer.cornerRadius = frameHeight/2.0
        self.layer.masksToBounds = true
        
        
        let step : CGFloat = 1.0/4.0 // whole circle di
        let start : CGFloat = 0.0
        let circle : CGFloat = CGFloat.pi * 2.0
        let radius : CGFloat = frameWidth * 0.5 - arrowWidth;
        
        self.setupDashLayer(dashLayer: firstDashLayer, path: firstDashPath,startAngle:start * circle,endAngle: CGFloat(start + step) * circle, center: arrowCenter, radius: radius,color: UIColor.red)
        
        self.setupDashLayer(dashLayer: secondDashLayer, path: secondDashPath,startAngle: (start + step) * circle,endAngle:((start + step*2) * circle), center: arrowCenter, radius: radius,color: UIColor.green)
        
        self.setupDashLayer(dashLayer: thirdDashLayer, path: thirdDashPath,startAngle:(start + step*2) * circle,endAngle: ((start + step*3) * circle), center: arrowCenter, radius: radius,color: UIColor.blue)
        
        self.setupDashLayer(dashLayer: fourthDashLayer, path: fourthDashPath,startAngle:((start + step*3) * circle),endAngle: ((start + step*4) * circle), center: arrowCenter, radius: radius,color: UIColor.cyan)
        
//        self.setupDashLayer(dashLayer: fifthDashLayer, path: fifthDashPath,startAngle:((start + step*4) * circle),endAngle:((start + step*5) * circle), center: arrowCenter, radius: radius,color: UIColor.yellow)
        
        self.setupDashLayer(dashLayer: hackDashLayer, path: hackDashPath,startAngle:((start + step*4) * circle),endAngle:((start + step*4.1) * circle), center: arrowCenter, radius: radius,color: UIColor.red)
        
    }

    
    func setupDashLayer(dashLayer : CAShapeLayer, path : UIBezierPath,startAngle : CGFloat,endAngle : CGFloat , center : CGPoint, radius : CGFloat, color : UIColor) -> Void {
        
        path.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle:endAngle, clockwise: true)
        dashLayer.path = path.cgPath
        dashLayer.fillColor = UIColor.clear.cgColor
        dashLayer.strokeColor = color.cgColor
        dashLayer.lineWidth = 40.0
        dashLayer.lineCap = kCALineCapRound
        
        self.layer.addSublayer(dashLayer)
    }
}
