//
//  CustomView.swift
//  CustomView
//
//  Created by Valentin Varbanov on 28.10.17.
//  Copyright © 2017 Valentin Varbanov. All rights reserved.
//

import UIKit

class CustomView: UIView {
    
    var segmentControl: UISegmentedControl!
    var coloredBox: UIView!
    var colors = [UIColor.blue, UIColor.green, UIColor.red]
    
    var choises: [String: UIColor] {
        set {
            let newSegment = UISegmentedControl(items: Array(newValue.keys))
            newSegment.frame = segmentControl.frame
            
            colors = Array(newValue.values)
            
            let root = segmentControl.superview!
            segmentControl.removeFromSuperview()
            root.addSubview(newSegment)
            segmentControl = newSegment
            
            newSegment.addTarget(root, action: #selector(changeColor(sender:)), for: .valueChanged)
        }
        
        get {
            return [String: UIColor]()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        createColoredBox()
        createSegmentedControl()
    }
    
    private func createSegmentedControl() {
        
        segmentControl = UISegmentedControl(items: ["Blue", "Green", "Red"])
        
        segmentControl.frame = CGRect(origin: CGPoint(x: 10, y: 10),
                                       size: CGSize(width: frame.width - 20, height: 30))
        
        segmentControl.addTarget(self, action: #selector(changeColor(sender:)), for: .valueChanged)
        
        addSubview(segmentControl)
    }
    
    private func createColoredBox() {
        
        coloredBox = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 50),
                                          size: CGSize(width: frame.width, height: frame.height - 50)))
        
        addSubview(coloredBox)
    }
    
    @objc func changeColor(sender: UISegmentedControl) {
        
        UIView.transition(with: coloredBox, duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: { [unowned self] in
                            
                            var color: UIColor
                            
                            if sender.selectedSegmentIndex < self.colors.count {
                                color = self.colors[sender.selectedSegmentIndex]
                            } else {
                                color = UIColor.clear
                            }
                            
                            self.coloredBox.backgroundColor = color
            },
                          completion: nil)
    }

}
