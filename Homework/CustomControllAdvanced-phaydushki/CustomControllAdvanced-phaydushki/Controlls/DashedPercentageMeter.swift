//
//  DashedPercentageMeter.swift
//  CustomControllAdvanced-phaydushki
//
//  Created by Petko Haydushki on 25.11.17.
//  Copyright © 2017 Petko Haydushki. All rights reserved.
//

import UIKit

class DashedPercentageMeter: UIView {
    
    let cicrleLayer : CAShapeLayer = CAShapeLayer.init()
    let lineDashLayer : CAShapeLayer = CAShapeLayer.init()
    let beginLayer : CAShapeLayer = CAShapeLayer.init()
    
    let cicrlePath : UIBezierPath = UIBezierPath()
    let lineDashPath : UIBezierPath = UIBezierPath()
    let beginDashPath : UIBezierPath = UIBezierPath()
    
    let lineWidth : CGFloat = 20.0
    var value : CGFloat = 44.0
    var beginAngle : CGFloat = 0.5
    
    let percentageLabel : UILabel = UILabel.init()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.black
    }
    
    override func draw(_ rect: CGRect)
    {
        let pi : CGFloat = CGFloat.pi

        self.cicrlePath.addArc(withCenter: CGPoint(x: rect.size.width/2.0, y: rect.height/2.0), radius:self.frame.size.width/2.0 - lineWidth/2.0, startAngle: 0.0*pi, endAngle: 2.0*pi, clockwise: true)
        
        self.lineDashPath.addArc(withCenter: CGPoint(x: rect.size.width/2.0, y: rect.height/2.0), radius:self.frame.size.width/2.0 - lineWidth/2.0, startAngle: beginAngle*pi, endAngle: 2.0*pi * (value/100.0) + beginAngle * pi, clockwise: true)

        self.beginDashPath.addArc(withCenter: CGPoint(x: rect.size.width/2.0, y: rect.height/2.0), radius:self.frame.size.width/2.0 - lineWidth/2.0, startAngle:beginAngle * 0.94 * pi, endAngle:beginAngle * 0.99 * pi, clockwise: true)
        
        
        self.percentageLabel.frame = CGRect.init(x: rect.size.width/2.0 - frame.size.width/4.0, y: rect.size.height/2.0 - frame.size.height/4.0, width: frame.size.width/2.0, height: frame.size.width/2.0)

        self.cicrleLayer.path = self.cicrlePath.cgPath
        self.cicrleLayer.fillColor = UIColor.clear.cgColor
        self.cicrleLayer.strokeColor = UIColor.gray.cgColor
        self.cicrleLayer.lineWidth = lineWidth

        self.lineDashLayer.path = self.lineDashPath.cgPath
        self.lineDashLayer.fillColor = UIColor.clear.cgColor
        self.lineDashLayer.strokeColor = UIColor.cyan.cgColor
        self.lineDashLayer.lineDashPattern = [3, 10]
        self.lineDashLayer.lineWidth = lineWidth

        self.beginLayer.path = self.beginDashPath.cgPath
        
        self.beginLayer.fillColor = UIColor.clear.cgColor
        self.beginLayer.strokeColor = UIColor.init(red: 39.0/255.0, green: 123.0/255.0, blue: 250.0/255.0, alpha: 1.0).cgColor
        self.beginLayer.lineDashPattern = [20, 100]
        self.beginLayer.lineWidth = lineWidth + 6.0
        
        self.layer.addSublayer(self.cicrleLayer)
        self.layer.addSublayer(self.lineDashLayer)
        self.layer.addSublayer(self.beginLayer)
        
        let gradientLayer : CAGradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds;
        gradientLayer.colors = [UIColor.init(red: 39.0/255.0, green: 123.0/255.0, blue: 250.0/255.0, alpha: 1.0).cgColor
            ,        UIColor.init(red: 39.0/255.0, green: 123.0/255.0, blue: 250.0/255.0, alpha: 0.4)
.cgColor];
        gradientLayer.startPoint = CGPoint(x:0,y:0.5);
        gradientLayer.endPoint = CGPoint(x:1,y:0.5);
        
        self.layer.addSublayer(gradientLayer)
        gradientLayer.mask = lineDashLayer;
        
        self.backgroundColor = UIColor.white
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.percentageLabel.text = String(format: "%.0f",value)
        percentageLabel.textColor = UIColor.white
        percentageLabel.font = UIFont.systemFont(ofSize: 52.0, weight: UIFont.Weight.regular)
        percentageLabel.textAlignment = NSTextAlignment.center
        
        self.addSubview(percentageLabel)
    }
    
    func updatePercentage(value : CGFloat) -> Void {

    let rect = frame
    let pi : CGFloat = CGFloat.pi
    
    self.lineDashPath.removeAllPoints()
        
    self.lineDashPath.addArc(withCenter: CGPoint(x: rect.size.width/2.0, y: rect.height/2.0), radius:self.frame.size.width/2.0 - lineWidth/2.0, startAngle: beginAngle*pi, endAngle: 2.0*pi * value + beginAngle * pi, clockwise: true)
    
    self.percentageLabel.text = String(format: "%.0f",100 * value)
    self.lineDashLayer.path = lineDashPath.cgPath

    }
    
}
