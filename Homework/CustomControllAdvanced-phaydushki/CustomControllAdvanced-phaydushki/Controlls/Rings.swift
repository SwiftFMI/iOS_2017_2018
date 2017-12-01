//
//  Rings.swift
//  CustomControllAdvanced-phaydushki
//
//  Created by Petko Haydushki on 25.11.17.
//  Copyright © 2017 Petko Haydushki. All rights reserved.
//

import UIKit

class Rings: UIView {
    
    let lineWidth : CGFloat = 50.0
    
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
        
        let arrowWidth : CGFloat = lineWidth
        
        let arrowCenter = CGPoint(x: (frameWidth / 2.0 ), y:frameHeight / 2.0)
        
        self.layer.cornerRadius = frameHeight/2.0
        self.layer.masksToBounds = true
        
        let redPart : CGFloat = 0.2
        let bluePart : CGFloat = 0.35
        let greenPart : CGFloat = 0.15
        let cyanPart : CGFloat = 0.3
        
        var redPartEnd : CGFloat = 0.0
        var bluePartEnd : CGFloat = 0.0
        var greenPartEnd : CGFloat = 0.0
        var cyanPartEnd : CGFloat = 0.0
        
        var start : CGFloat = 0.0
        let circle : CGFloat = CGFloat.pi * 2.0
        let radius : CGFloat = frameWidth * 0.5 - arrowWidth/2.0;
        
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
        
        self.setPercentageLabel(part: redPart, partEnd: redPartEnd)
        self.setPercentageLabel(part: bluePart, partEnd: bluePartEnd)
        self.setPercentageLabel(part: greenPart, partEnd: greenPartEnd)
        self.setPercentageLabel(part: cyanPart, partEnd: cyanPartEnd)
    }
    
    func setPercentageLabel(part : CGFloat,partEnd : CGFloat) -> Void {
        
        let circle : Double = Double.pi * 2.0
        
        let frameSizeHeight = Double((frame.size.height - lineWidth)/2.0)
        let frameSizeWidth = Double((frame.size.width - lineWidth)/2.0)
        let r = Double((frame.size.width - lineWidth)/2)

        let xz : CGFloat = CGFloat(r * cos(circle * Double(partEnd)) + frameSizeWidth);
        let yz : CGFloat = CGFloat(r * sin(circle * Double(partEnd)) + frameSizeHeight);
        
        let label = UILabel.init(frame: CGRect.init(x: xz, y: yz, width: lineWidth, height: lineWidth))
        label.text = String(format: "%.0f",part * 100)
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 26.0, weight: UIFont.Weight.regular)
        self.addSubview(label)
    }

    func setupDashLayer(startAngle : CGFloat,endAngle : CGFloat , center : CGPoint, radius : CGFloat, color : UIColor) -> Void {
        
        let dashLayer : CAShapeLayer = CAShapeLayer.init();
        let path : UIBezierPath = UIBezierPath()
        
        path.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle:endAngle, clockwise: true)
        dashLayer.path = path.cgPath
        dashLayer.fillColor = UIColor.clear.cgColor
        dashLayer.strokeColor = color.cgColor
        dashLayer.lineWidth = lineWidth
        dashLayer.lineCap = kCALineCapRound
        
        self.layer.addSublayer(dashLayer)
    }
}
