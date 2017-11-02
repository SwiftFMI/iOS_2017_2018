//
//  MyTabView.swift
//  SecondSwiftFMITask
//
//  Created by Petko Haydushki on 28.10.17.
//  Copyright © 2017 Petko Haydushki. All rights reserved.
//

import UIKit

protocol MyTabViewProtocol: class {
    
    func valueChange(index : Int) -> Void
}

class MyTabView: UIView {

    var segment : UISegmentedControl;
    weak var delegate: MyTabViewProtocol?

    override init(frame: CGRect) {
        
        let itemArray : [String] = ["Red","Green","Blue"]

        self.segment = UISegmentedControl.init(items: itemArray)
        
        segment.backgroundColor = UIColor.red
        
        super.init(frame: frame)
        
        self.segment.frame = self.frame
        self.segment.addTarget(self, action: #selector(valueChanged(segment:)), for: UIControlEvents.valueChanged)
        self.addSubview(segment)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //SegmentControlValueChange
    @objc func valueChanged(segment:UISegmentedControl) -> Void {
        let index = segment.selectedSegmentIndex
        self.delegate?.valueChange(index: index)
    }
    
}
