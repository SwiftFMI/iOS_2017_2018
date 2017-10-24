//
//  SuccessViewController.swift
//  SwiftFmi
//
//  Created by Petko Haydushki on 24.10.17.
//  Copyright © 2017 Petko Haydushki. All rights reserved.
//

import UIKit

class SuccessViewController: UIViewController {

    var labelText = "Empty"
    
    @IBOutlet weak var successLabel: UILabel!
    @IBOutlet weak var logOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.logOutButton.layer.borderColor = UIColor.white.cgColor
        self.logOutButton.layer.borderWidth = 2
        self.logOutButton.layer.cornerRadius = 8.0;
        
        self.successLabel.text = labelText;
    }

    @IBAction func logOutAction(_ sender: Any) {
        self.dismiss(animated: true) {
        }
    }
}
