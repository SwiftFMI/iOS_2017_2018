//
//  MeterCircularView.swift
//  CustomControllAdvanced-phaydushki
//
//  Created by Petko Haydushki on 16.11.17.
//  Copyright © 2017 Petko Haydushki. All rights reserved.
//

import UIKit

class MeterCircularView: UIView {

    var arrowLayer : CAShapeLayer = CAShapeLayer.init();
    var arrowPath : UIBezierPath = UIBezierPath()

    var circleLayer : CAShapeLayer = CAShapeLayer.init();
    var circlePath : UIBezierPath = UIBezierPath()
    
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

    
    override func draw(_ rect: CGRect) {

        let frameWidth = frame.size.width
        let frameHeight = frame.size.height
        
        let arrowWidth : CGFloat = 30.0
        
        let arrowTop = CGPoint(x: (frameWidth / 2.0 ) + 0.0, y:arrowWidth)
        let arrowCenter = CGPoint(x: (frameWidth / 2.0 ), y:frameHeight / 2.0)
        
        arrowPath.move(to: CGPoint(x: (frameWidth / 2.0 ) - arrowWidth/2.0, y: (frameHeight/2.0)))
        arrowPath.addLine(to: arrowTop)
        arrowPath.addLine(to: CGPoint(x: (frameWidth / 2.0 ) + arrowWidth/2.0, y: (frameHeight/2.0)))
        arrowPath.addLine(to: CGPoint(x: (frameWidth / 2.0 ) - arrowWidth/2.0, y: (frameHeight/2.0)))
        arrowPath.move(to: arrowCenter)
        
        self.layer.cornerRadius = frameHeight/2.0
        self.layer.masksToBounds = true
        
        arrowPath.addArc(withCenter: arrowCenter, radius: arrowWidth * 0.8, startAngle: 0, endAngle: CGFloat(Double.pi * 2.0), clockwise: true)
        
        arrowLayer.path = arrowPath.cgPath
        arrowLayer.fillColor = UIColor.red.cgColor
        arrowLayer.strokeColor = UIColor.red.cgColor
        arrowLayer.lineWidth = 1.0;
        arrowLayer.bounds = self.layer.bounds
        arrowLayer.position = CGPoint (x:frameWidth/2.0, y: frameHeight/2.0);
        arrowLayer.anchorPoint =  CGPoint(x: 0.5, y:0.5)
    
        circlePath.addArc(withCenter: arrowCenter, radius: frameWidth * 0.5, startAngle: 0, endAngle: CGFloat(Double.pi * 2.0), clockwise: true)
    
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor        
        circleLayer.strokeColor = UIColor.cyan.cgColor
        circleLayer.lineWidth = 10.0
        
        let step : CGFloat = 0.15
        let start : CGFloat = 0.375
        let circle : CGFloat = CGFloat(Double.pi * 2.0)
        let radius : CGFloat = frameWidth * 0.5 - arrowWidth;
        
        self.setupDashLayer(dashLayer: firstDashLayer, path: firstDashPath,startAngle:start * circle,endAngle: CGFloat(start + step) * circle, center: arrowCenter, radius: radius,color: UIColor.red)
        
        self.setupDashLayer(dashLayer: secondDashLayer, path: secondDashPath,startAngle: (start + step) * circle,endAngle:((start + step*2) * circle), center: arrowCenter, radius: radius,color: UIColor.green)
        
        self.setupDashLayer(dashLayer: thirdDashLayer, path: thirdDashPath,startAngle:(start + step*2) * circle,endAngle: ((start + step*3) * circle), center: arrowCenter, radius: radius,color: UIColor.blue)
        
        self.setupDashLayer(dashLayer: fourthDashLayer, path: fourthDashPath,startAngle:((start + step*3) * circle),endAngle: ((start + step*4) * circle), center: arrowCenter, radius: radius,color: UIColor.cyan)
        
        self.setupDashLayer(dashLayer: fifthDashLayer, path: fifthDashPath,startAngle:((start + step*4) * circle),endAngle:((start + step*5) * circle), center: arrowCenter, radius: radius,color: UIColor.yellow)
        
        
        self.layer.addSublayer(circleLayer)
        self.layer.addSublayer(firstDashLayer)
        self.layer.addSublayer(secondDashLayer)
        self.layer.addSublayer(thirdDashLayer)
        self.layer.addSublayer(fourthDashLayer)
        self.layer.addSublayer(fifthDashLayer)
        self.layer.addSublayer(arrowLayer)
    }
 
    func valueChanged(value : Double) -> Void {
        
        var normalizedValue = value - 0.5
        
        let maxAngle = 0.35
        if (normalizedValue < -maxAngle)
        {
            normalizedValue = -maxAngle
        }
        if (normalizedValue > maxAngle)
        {
            normalizedValue = maxAngle
        }
        arrowLayer.transform = CATransform3DMakeRotation(CGFloat(normalizedValue * Double.pi * 2.0), 0.0, 0.0, 1.0)
    }
    
    func setupDashLayer(dashLayer : CAShapeLayer, path : UIBezierPath,startAngle : CGFloat,endAngle : CGFloat , center : CGPoint, radius : CGFloat, color : UIColor) -> Void {
        
        path.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle:endAngle, clockwise: true)
        dashLayer.path = path.cgPath
        dashLayer.fillColor = UIColor.clear.cgColor
        dashLayer.strokeColor = color.cgColor
        dashLayer.lineWidth = 40.0
    }

}
