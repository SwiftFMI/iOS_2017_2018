//
//  SecondViewController.swift
//  LoginApp
//
//  Created by Petar Ivanov on 10/22/17.
//  Copyright © 2017 SwiftFMI. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var loggedInLabel: UILabel!
    
    var loggedInAsString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        loggedInLabel.text = "Logged in as \(loggedInAsString)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
