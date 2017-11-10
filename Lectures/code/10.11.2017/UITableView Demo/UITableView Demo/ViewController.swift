//
//  ViewController.swift
//  UITableView Demo
//
//  Created by Emil Atanasov on 11/10/17.
//  Copyright © 2017 SwiftFMI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


class TableViewController: UITableViewController {
    
    var items:[String] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for i in 1...10 {
            items.append("Item \(i)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

class TableViewControllerFinal: UITableViewController {
    
    var items:[String] = [];
    
    let sections = 1
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return sections
//    }
//
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Section \(section + 1)"
//    }
//
//    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        var r:[String] = []
//        for i in 1...sections {
//            r.append("Section \(i)")
//        }
//
//        return r
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")
        
        let data = items[indexPath.row]
        
        cell?.textLabel?.text = data
        
        return cell!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for i in 1...10 {
            items.append("Item \(i)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

