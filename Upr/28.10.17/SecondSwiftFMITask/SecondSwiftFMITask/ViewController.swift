//
//  ViewController.swift
//  SecondSwiftFMITask
//
//  Created by Petko Haydushki on 28.10.17.
//  Copyright © 2017 Petko Haydushki. All rights reserved.
//

import UIKit


class ViewController: UIViewController , MyTabViewProtocol {


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myTabView : MyTabView = MyTabView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height/10))
        let myOtherView : UIView = UIView.init(frame: CGRect.init(x: 20, y: myTabView.frame.size.height + 50, width: myTabView.frame.size.width - 40, height: self.view.frame.size.height - 120 - myTabView.frame.size.height))
        
        myTabView.delegate = self;
        
        myOtherView.backgroundColor = UIColor.red
        self.view.addSubview(myTabView)
        self.view.addSubview(myOtherView)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func valueChange(index : Int) -> Void {
        print("\(index)")
        
    }

}

