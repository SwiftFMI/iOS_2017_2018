//
//  ItemsViewController.swift
//  FirebaseDemo
//
//  Created by Emil Atanasov on 5.01.18.
//  Copyright © 2018 SwiftFMI. All rights reserved.
//
// Further infromation:
// https://firebase.google.com/docs/database/ios/start

import UIKit
import Firebase

public class ItemsViewController : UITableViewController {
    var ref: DatabaseReference!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        //load data
        loadData()
    }
    
    func loadData() {
        ref = Database.database().reference(withPath: "items")
        
        _ = ref.observe(.value, with: { (snapshot) in
            let items = snapshot.value as? [String : Bool] ?? [:]
            // ...
            print("\(items)")
        })
    }
    
    
}
