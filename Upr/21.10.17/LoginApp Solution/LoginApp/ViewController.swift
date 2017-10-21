//
//  ViewController.swift
//  LoginApp
//
//  Created by Emil Atanasov on 10/21/17.
//  Copyright © 2017 SwiftFMI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // show fields and hide hello message
        loggedIn = false
        helloLabel.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var helloLabel: UILabel!
    var helloText = "" {
        didSet {
            helloLabel.text = helloText
        }
    }
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var button: UIButton!
    var loggedIn = false {
        didSet { // on change
            
            var image: UIImage
            if loggedIn {
                emailField.isHidden = true
                passwordField.isHidden = true
                helloLabel.isHidden = false
                
                image = #imageLiteral(resourceName: "icons8-Login-100")
            } else {
                emailField.isHidden = false
                passwordField.isHidden = false
                helloLabel.isHidden = true
                
                image = #imageLiteral(resourceName: "icons8-Sign Out-100")
            }
            
            UIView.transition(with: button, duration: 0.5,
                              options: .transitionFlipFromRight,
                              animations: { [unowned self] in
                                  self.button.setImage(image, for: .normal)
                              },
                              completion: nil)
        }
    }
    
    @IBAction func login(_ sender: Any) {
        
        // check for filled in mail
        guard let email = emailField.text else { return }
        guard let password = passwordField.text else { return }
        
        // if logged in -> log out
        if loggedIn {
            loggedIn = false
            print("Logged out")
            return
        }
        
        // try to log in
        print("Trying email: \(email) password: \(password) ")
        
        if email.isValidEmail() {
            print("The email is a valid format")
            // we just need a valid email to log in
            // every password is OK
            loggedIn = true
            
            helloText = "Logged in as \(email)"
            
            // clear fields so next attempt should not remember them
            emailField.text     = ""
            passwordField.text  = ""
            
        } else {
            print("Invalid email...")
        }
    }

    
}

// copied from internet
extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$",
                                             options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: characters.count)) != nil
    }
}

