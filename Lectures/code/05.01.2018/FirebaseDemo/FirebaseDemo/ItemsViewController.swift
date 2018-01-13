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
    var allItems: [String] = []
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        //load data
        loadData()
    }
    
    func loadData() {
        ref = Database.database().reference(withPath: "items")
        
        _ = ref.observe(.value, with: {  [weak self] (snapshot) in
            let items = snapshot.value as? [String : Bool] ?? [:]
            // ...
            print("\(items)")
            var availableItems:[String] = []
            for key in items.keys {
                if items[key] == true {
                    availableItems.append(key)
                }
            }
            
            self?.allItems = availableItems
            self?.tableView.reloadData()
            
        })
    }
    
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allItems.count
    }
    
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")
        
        cell?.textLabel?.text = self.allItems[indexPath.row]
        
        return cell!
    }
    
}
