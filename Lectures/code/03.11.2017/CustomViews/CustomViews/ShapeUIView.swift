//
//  CustomUIView.swift
//  CustomViews
//
//  Created by Emil Atanasov on 11/3/17.
//  Copyright © 2017 SwiftFMI. All rights reserved.
//

import UIKit

class ShapeUIView: UIView {
    //TODO: add default properties
    let lineWidth:CGFloat = 5
    //used when initialised through code
    public override init(frame: CGRect) {
        super.init(frame: frame)
        print("\(#function)")
        self.setup()
    }
    //used when initialised through storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        print("\(#function)")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        //CoreGraphics way
        let cgContext = UIGraphicsGetCurrentContext()
        if let context = cgContext {
//            context.clear(rect)
            context.setLineCap(.round)
            context.setLineJoin(.round)
            context.setStrokeColor(UIColor.blue.cgColor)
            context.setLineWidth(lineWidth)
            context.addArc(center: self.center, radius: (self.frame.width - lineWidth)/2, startAngle: 0, endAngle: 360, clockwise: false)

            context.strokePath()
        }
        
        
    }
}
