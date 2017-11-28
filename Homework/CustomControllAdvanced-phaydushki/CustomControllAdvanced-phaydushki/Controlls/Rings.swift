//
//  Rings.swift
//  CustomControllAdvanced-phaydushki
//
//  Created by Petko Haydushki on 25.11.17.
//  Copyright © 2017 Petko Haydushki. All rights reserved.
//

import UIKit

class Rings: UIView {
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        self.setupRings()
    }
    
    func setupRings() -> Void {
        let frameWidth = frame.size.width
        let frameHeight = frame.size.height
        
        let arrowWidth : CGFloat = 30.0
        
        let arrowCenter = CGPoint(x: (frameWidth / 2.0 ), y:frameHeight / 2.0)
        
        self.layer.cornerRadius = frameHeight/2.0
        self.layer.masksToBounds = true
        
        
        let redPart : CGFloat = 0.2
        let bluePart : CGFloat = 0.35
        let greenPart : CGFloat = 0.15
        let cyanPart : CGFloat = 0.3
        
        var redPartEnd : CGFloat = 0.2
        var bluePartEnd : CGFloat = 0.35
        var greenPartEnd : CGFloat = 0.15
        var cyanPartEnd : CGFloat = 0.3
        
        var start : CGFloat = 0.0
        let circle : CGFloat = CGFloat.pi * 2.0
        let radius : CGFloat = frameWidth * 0.5 - arrowWidth;
        
        self.setupDashLayer(startAngle:start * circle,endAngle: CGFloat(start + redPart) * circle, center: arrowCenter, radius: radius,color: UIColor.red)
        
        start += redPart
        redPartEnd = start
        self.setupDashLayer(startAngle:start * circle,endAngle:(start + greenPart) * circle, center: arrowCenter, radius: radius,color: UIColor.green)
        
        start += greenPart
        greenPartEnd = start
        self.setupDashLayer(startAngle:start * circle,endAngle: ((start + bluePart) * circle), center: arrowCenter, radius: radius,color: UIColor.blue)
        
        start += bluePart
        bluePartEnd = start
        self.setupDashLayer(startAngle:start * circle,endAngle: ((start + cyanPart) * circle), center: arrowCenter, radius: radius,color: UIColor.cyan)
        
        start += cyanPart
        cyanPartEnd = start
        self.setupDashLayer(startAngle:0.0  * circle,endAngle:0.01 * circle, center: arrowCenter, radius: radius,color: UIColor.red)
        
        self.setPercentageLabel(part: redPart, partEnd: redPartEnd, color: UIColor.orange)
        self.setPercentageLabel(part: bluePart, partEnd: bluePartEnd, color: UIColor.orange)
        self.setPercentageLabel(part: greenPart, partEnd: greenPartEnd, color: UIColor.orange)
        self.setPercentageLabel(part: cyanPart, partEnd: cyanPartEnd, color: UIColor.orange)
    }
    
    func setPercentageLabel(part : CGFloat,partEnd : CGFloat , color : UIColor) -> Void {
        
        let circle : Double = Double.pi * 2.0
        
        let frameSizeHeight = Double((frame.size.height - 40)/2.0)
        let frameSizeWidth = Double((frame.size.width - 40)/2.0)
        let r = Double((frame.size.width - 55)/2)

        let xz = r * cos(circle * Double(partEnd)) + frameSizeWidth;
        let yz = r * sin(circle * Double(partEnd)) + frameSizeHeight;
        
        let label = UILabel.init(frame: CGRect.init(x: xz, y: yz, width: 30, height: 30))
        label.text = String(format: "%.0f",part * 100)
        label.textColor = UIColor.white
        label.backgroundColor = color
        label.textAlignment = NSTextAlignment.center
        self.addSubview(label)
    }

    func setupDashLayer(startAngle : CGFloat,endAngle : CGFloat , center : CGPoint, radius : CGFloat, color : UIColor) -> Void {
        
        let dashLayer : CAShapeLayer = CAShapeLayer.init();
        let path : UIBezierPath = UIBezierPath()
        
        path.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle:endAngle, clockwise: true)
        dashLayer.path = path.cgPath
        dashLayer.fillColor = UIColor.clear.cgColor
        dashLayer.strokeColor = color.cgColor
        dashLayer.lineWidth = 40.0
        dashLayer.lineCap = kCALineCapRound
        
        self.layer.addSublayer(dashLayer)
    }
}
