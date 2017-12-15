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
    var highlight: Bool = false
    
    var downloading = false
    var downloaded = false
    var progress : CGFloat = 0.0
    
    let downloadString : String = "Download!"
    let openString : String = "Open"
    let closeSymbol : String = "✖"
    
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
        
        self.titleLabel?.font = UIFont.systemFont(ofSize: 40.0, weight: UIFont.Weight.regular)
        
        self.layer.borderWidth = 2.0
        //26 160 215
        
        self.layer.borderColor = controllColor.cgColor
        self.layer.cornerRadius = self.frame.height/2.0
        self.layer.masksToBounds = true
        
        
        self.setTitleColor(controllColor, for: UIControlState.normal)
        self.titleEdgeInsets = UIEdgeInsetsMake(0.0, 15.0, 0.0, 15.0)

        self.updateButton(withTitleText: downloadString)
        
        self.addTarget(self, action: #selector(sel), for: UIControlEvents.touchUpInside)
    }
    
    
    override var isHighlighted: Bool {
      
        didSet {
            if (isHighlighted)
            {
                if (!self.highlight)
                {
                    self.viewScaleAnimation(fromValue: NSNumber.init(value: 1), toValue: NSNumber.init(value: 0.96), duration: 0.2)
                    self.highlight = false;
                }
            }
            else
            {
                self.viewScaleAnimation(fromValue: NSNumber.init(value: 0.96), toValue:NSNumber.init(value: 1), duration: 0.2)
            }
            self.highlight = isHighlighted;
        }
    }
    
    
    func viewScaleAnimation(fromValue : NSNumber, toValue: NSNumber , duration : CGFloat)
    {
        let scaleAnimation = CABasicAnimation(keyPath:"transform.scale")
        scaleAnimation.fromValue = fromValue
        scaleAnimation.toValue = toValue
        scaleAnimation.duration = CFTimeInterval(duration)
        self.layer.contentsScale = UIScreen.main.scale
        scaleAnimation.isRemovedOnCompletion = false
        scaleAnimation.fillMode = kCAFillModeForwards
        self.layer.add(scaleAnimation, forKey: "transform.scale")
    }

    @objc func sel() -> Void {
        if (downloaded == true)
        {
            self.updateButton(withTitleText: downloadString)
            downloaded = false
            downloading = false
        }
        else
        {
            if (downloading == true)
            {
                self.updateButton(withTitleText: downloadString)
                
                self.circleLayer.removeAnimation(forKey: "animateCircle")
                self.circleLayer.removeFromSuperlayer()
                downloading = false
            }
            else
            {
                downloading = true

                self.updateButton(withTitleText: closeSymbol)
                self.layer.addSublayer(circleLayer)
                self.animateLoading(fromValue: CGFloat(progress), toValue: 0.5)
            }
        }
    }
    
    
    func animateLoading(fromValue : CGFloat , toValue : CGFloat) -> Void {
        
        CATransaction.begin()
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 1.0
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        circleLayer.strokeEnd = toValue
        
        CATransaction.setCompletionBlock {
            if (toValue == 1.0)
            {
                self.circleLayer.removeFromSuperlayer()

                self.updateButton(withTitleText: self.openString)

                self.downloading = false
                self.downloaded = true
                self.progress = 0.0
            }
            else
            {
                self.progress = toValue
                self.animateLoading(fromValue: toValue, toValue: (toValue + 0.25))
            }
        }
        // Do the actual animation
        circleLayer.add(animation, forKey: "animateCircle")
        CATransaction.commit()
    }
    
    func updateButton(withTitleText text : String) -> Void {
    
        let size = text.size(withAttributes:[NSAttributedStringKey.font: UIFont.systemFont(ofSize: 40.0)])
        
        UIView.animate(withDuration: 0.2, animations: {
            let oldWidth = self.frame.size.width
            if (text == self.closeSymbol)
            {
                let newWidth = self.frame.size.height
                self.frame = CGRect.init(x: self.frame.origin.x - (newWidth - oldWidth)/2.0, y: self.frame.origin.y, width: self.frame.size.height, height: self.frame.size.height)
                self.layer.cornerRadius = self.frame.size.height/2.0
            }
            else
            {
                let newWidth = size.width + self.titleEdgeInsets.left + self.titleEdgeInsets.right
                self.frame = CGRect.init(x: self.frame.origin.x - (newWidth - oldWidth)/2.0, y: self.frame.origin.y, width: newWidth, height: self.frame.size.height)
                self.layer.cornerRadius = 5.0
            }
            UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve, animations: {
                self.setTitle(text, for: .normal)
            }, completion: nil)
        })
    }
    
    
}
