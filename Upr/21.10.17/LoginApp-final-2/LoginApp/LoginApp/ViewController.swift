//
//  ViewController.swift
//  LoginApp
//
//  Created by Emil Atanasov on 10/21/17.
//  Copyright © 2017 SwiftFMI. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        loggedIn = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var loggedIn = false {
        // when the value of the loggedIn property is changed the following code is execuded
        didSet {
            if loggedIn {
                print("You're logged in!")
            } else {
                print("You're not logged in!")
            }
        }
    }
    
    @IBAction func login(_ sender: UIButton) {
        guard let email    = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        print("Someone is trying to log in with: \nemail: \(email) and password: \(password)")
        
        if email.isValidEmail() {
            print("You're logged in as \(email)")
            loggedIn = true
            
            performSegue(withIdentifier: "loginSegue", sender: self)
        } else {
            print("Invalid email! Please try again!")
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let email = emailTextField.text else { return }
        let secondController = segue.destination as! SecondViewController
        secondController.loggedInAsString = email
    }
    
    /// hide keyboard when the login button is pressed
    ///
    /// - Parameter sender: login button
    @IBAction func loginBtnPressed(_ sender: UIButton) {
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
    }
    
    // built in method
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    /// enable Next button on keyboard to go to passwordTextField while editing emailTextField
    /// enable Done button on the keyboard to hide keyboard while editing passwordTextField
    ///
    /// - Parameter textField: current textField we're editing
    /// - Returns: true because textField should always ...
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.emailTextField {
            self.passwordTextField.becomeFirstResponder()
        }
        if textField == self.passwordTextField {
            self.passwordTextField.resignFirstResponder()
        }
        return true
    }
}

// copied from the internet
extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let validEmailPattern = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
//        let pattern = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        let regex = try! NSRegularExpression(pattern: validEmailPattern, options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: characters.count)) != nil
    }
}

