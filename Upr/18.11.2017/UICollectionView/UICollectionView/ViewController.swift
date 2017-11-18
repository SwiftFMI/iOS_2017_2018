//
//  ViewController.swift
//  UICollectionView
//
//  Created by Emil Atanasov on 18.11.17.
//  Copyright © 2017 SwiftFMI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //може да изпозлвате тези тестови данни
        let emails = Email.getMockEmails(items: 5)
        print(emails)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

