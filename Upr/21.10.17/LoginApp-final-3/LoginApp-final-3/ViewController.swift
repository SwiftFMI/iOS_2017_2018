//
//  ViewController.swift
//  SwiftFmi
//
//  Created by Petko Haydushki on 21.10.17.
//  Copyright © 2017 Petko Haydushki. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    /// This outlet is used to move the login button upwards when the keyboard is changing its frame.
    /// Its relative to the bottom of the screen and you can move the button by changing the value
    /// of the constant property of NSLayoutConstraint class instances.
    @IBOutlet weak var loginButtonVerticalSpaceToSafeAreaBottom: NSLayoutConstraint!
    
    /// This data set represents key:value pairs (username:password)
    var userData : [String : String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // You can change the alpha channel of UIView class and subclasses instances
        // You can use this property to show/hide views or achieve some kind of animation behaviour
        self.infoLabel.alpha = 0.0;
        
        // This is how we round UIView and set a border. Often you should use maskToBounds property
        self.loginButton.layer.borderColor = UIColor.white.cgColor
        self.loginButton.layer.borderWidth = 2
        self.loginButton.layer.cornerRadius = 8.0;
        
        // Here we are subscribing for the system notification (event) when the keyboard is going to change its frame.
        // There are a lot of system notifications that we can subscribe for, e.g rotation changes, keyboard events, application state changes etc.
        // More interesting is that you can create your own and subscribe to them somewhere else in the project
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        // UserDefaults can be used to persist some information,mainly user preferences or some other small size data.
        // See documentation for further info
        if (UserDefaults.standard.object(forKey: "userData") != nil)
        {
            userData = UserDefaults.standard.object(forKey: "userData") as! [String : String]
        }
        else
        {
            userData = [:]
        }
    }

    @IBAction func loginButtonAction(_ sender: Any) {
        print("LoginBtn")
        
        // When you want to animate properties of UIView instances you should embed you animation code inside UIView.animate block
        UIView.animate(withDuration: 0.3) {
            self.infoLabel.alpha = 1.0;
        }
        
        if successfullLogin(usernameTextField: usernameTextField, passwordTextField: passwordTextField)
        {
            let user = usernameTextField.text!
            
            print("You are now logged in as \(user)")
            self.performSegue(withIdentifier: "successfullLogin", sender: self)
        }
        else
        {
            self.infoLabel.text = "Incorect username or password"
            print("user not exist")
        }
    }
    
    @IBAction func registerButtonAction(_ sender: Any) {
        
        if (isValidRegex(textField: usernameTextField) && isValidRegex(textField: passwordTextField))
        {
            let name = usernameTextField.text!
            
            self.infoLabel.text = "Registered \(name)"
            userData[usernameTextField.text!] = passwordTextField.text
        
            UserDefaults.standard.set(userData, forKey: "userData")
            
            // This is how we can delay execution of some code
            DispatchQueue.main.asyncAfter(deadline:.now() + 0.5, execute: {
                self.performSegue(withIdentifier: "successfullLogin", sender: self)
            })
            
            print("Registered \(name)")
        }
        else
        {
            self.infoLabel.text = "Username or password validation failed"
        }
       
        UIView.animate(withDuration: 0.3) {
            self.infoLabel.alpha = 1.0;
        }
    }
    
    // MARK: - UITextField Delegate methods - I've set the delegate of usernameTextField and passwordTextField in the interface builder to delegate this methods to our ViewController. We can also set them programatically.
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        textField.becomeFirstResponder()
        
        if (textField == usernameTextField)
        {
            print("textFieldDidBeginEditing :: username")
        }
        else
        {
            print("textFieldDidBeginEditing :: password")
        }
    }
    
    func successfullLogin(usernameTextField : UITextField,passwordTextField : UITextField) -> Bool {
        if (isValidRegex(textField: usernameTextField) && isValidRegex(textField: passwordTextField))
        {
            if userData.count > 0 && userData[usernameTextField.text!] != nil && userData[usernameTextField.text!]! == passwordTextField.text!
            {
                return true
            }
        }
        return false
    }
    
    func isValidRegex(textField : UITextField) -> Bool {
        if (textField == usernameTextField)
        {
            if (textField.text?.contains("@"))! && (textField.text?.count)! >= 8
            {
                return true
            }
            return false
        }
        else if (textField == passwordTextField)
        {
            return true;
        }
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        print("textFieldShouldReturn")
        
        if (textField == usernameTextField)
        {
            passwordTextField.becomeFirstResponder()
        }

        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing");
    }
    
    
    // MARK: - Keyboard Notification Handlers
    @objc func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            if (endFrame?.origin.y)! >= UIScreen.main.bounds.size.height {
                self.loginButtonVerticalSpaceToSafeAreaBottom?.constant = 80.0
                print(NSStringFromCGRect(endFrame!))
            } else {
                print(NSStringFromCGRect(endFrame!))
                
                self.loginButtonVerticalSpaceToSafeAreaBottom?.constant = ((endFrame?.size.height)! + 20)
                
            }
            
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }

    // MARK: - Segue Handlers
    // Here we can decide what to do before performing our segues (transitions)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let succ = segue.destination as! SuccessViewController
        let name = self.usernameTextField.text!
        
        succ.labelText = "You are now logged in as \(name)"
        succ.username = name
    }
}

