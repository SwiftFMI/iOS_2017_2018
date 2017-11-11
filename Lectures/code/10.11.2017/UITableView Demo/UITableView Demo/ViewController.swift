//
//  ViewController.swift
//  UITableView Demo
//
//  Created by Emil Atanasov on 11/10/17.
//  Copyright © 2017 SwiftFMI. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for i in 1...50 {
            items.append("New Item \(i)")
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }

    @IBAction func deleteItem(_ sender: Any) {
        
        items.removeFirst()
        
//        tableView.reloadData();
        
        tableView.beginUpdates()
        tableView.deleteRows(at:[IndexPath(row: 0, section: 0)], with: .right)
        tableView.endUpdates()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        
        print(item)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //:MARK dataSource

    var items:[String] = [];
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("IP: \(indexPath)")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell")
        
        let item = items[indexPath.row]
        
        cell?.textLabel?.text = item
        return cell!
    }
    
    // :MARK
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        let item = items[indexPath.row]
//        print("\(item) - \(editingStyle)")
//    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
                let item = items[indexPath.row]
                print("\(item)")
        
        let more = UITableViewRowAction(style: .normal, title: "More") { action, index in
            //self.isEditing = false
            print("more button tapped")
        }
        more.backgroundColor = UIColor.lightGray
        
        let favorite = UITableViewRowAction(style: .normal, title: "Favorite") { action, index in
            //self.isEditing = false
            print("favorite button tapped")
        }
        favorite.backgroundColor = UIColor.orange
        
        let share = UITableViewRowAction(style: .normal, title: "Share") { action, index in
            //self.isEditing = false
            print("share button tapped")
        }
        share.backgroundColor = UIColor.blue
        
        return [share, favorite, more]
    }
}


class TableViewController: UITableViewController {
    
    var items:[String] = [];
    let sections = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for i in 1...15 {
            items.append("Item \(i)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section + 1)"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
           return sections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell? = nil
        print("IP: \(indexPath)")
        
        
        
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "myButtonCell")
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "myCell")
        }
        
        let item = items[indexPath.row]
        
        cell?.textLabel?.text = item
//        cell?.textLabel?.backgroundColor = UIColor.green
        
//        cell?.textLabel?.textColor = UIColor.red
        return cell!
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        var r:[String] = []
        for i in 1...sections {
            r.append("Section \(i)")
        }

        return r
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

