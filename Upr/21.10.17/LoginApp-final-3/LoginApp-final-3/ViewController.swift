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
    @IBOutlet weak var loginButtonVerticalSpaceToSafeAreaBottom: NSLayoutConstraint!
    
    var userData : [String : String] = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.infoLabel.alpha = 0.0;
        
        self.loginButton.layer.borderColor = UIColor.white.cgColor
        self.loginButton.layer.borderWidth = 2
        self.loginButton.layer.cornerRadius = 8.0;
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        userData = ["Gosho@gmail.com": "passwordGosho",
                    "Pesho@abv.bg": "PeshoPass",
                    "Liliana@yahoo.com": "Lili"]
    }

    @IBAction func loginButtonAction(_ sender: Any) {
        print("LoginBtn")
        
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
            print("user not exist")
        }
//        if (isValidRegex(textField: self.usernameTextField)
//            && isValidRegex(textField: self.passwordTextField))
//        {
//            infoLabel.text = "You are now logged in";
//        }
//        else
//        {
//            infoLabel.text = "Wrong input";
//        }
    }
    
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
            if userData[usernameTextField.text!]! == passwordTextField.text
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let succ = segue.destination as! SuccessViewController
        let name = self.usernameTextField.text!
        
        succ.labelText = "You are now logged in as \(name)"
    }
}

