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
    var username = "Empty"
    
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
        
        let controller = self.presentingViewController as! ViewController
        controller.usernameTextField.text = ""
        controller.passwordTextField.text = ""
        
        self.dismiss(animated: true)
    }
    
    @IBAction func deleteAccount(_ sender: Any) {
        if (UserDefaults.standard.object(forKey: "userData") != nil)
        {
            var userData = UserDefaults.standard.object(forKey: "userData") as! [String : String]
            userData.removeValue(forKey: username)
            
            let controller = self.presentingViewController as! ViewController
            controller.userData = userData
            
            UserDefaults.standard.set(userData, forKey: "userData")
            self.dismiss(animated: true)
        }
    }
}
