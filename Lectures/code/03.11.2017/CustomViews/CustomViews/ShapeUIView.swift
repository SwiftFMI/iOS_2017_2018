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
        //TODO: do the custom drawing
        
        
    }
}
