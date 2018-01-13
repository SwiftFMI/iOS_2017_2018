//
//  ViewController.swift
//  CustomViews
//
//  Created by Emil Atanasov on 11/3/17.
//  Copyright © 2017 SwiftFMI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var customView: CustomUIView!
    
    var shapeView: ShapeUIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.shapeView = ShapeUIView.init(frame: CGRect(x:0, y:0, width: 300, height:300))
        self.shapeView?.backgroundColor = .red
        if let shapeView = self.shapeView {
            self.view.addSubview(shapeView);
        }
        
        self.customView.backgroundColor = .green
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

