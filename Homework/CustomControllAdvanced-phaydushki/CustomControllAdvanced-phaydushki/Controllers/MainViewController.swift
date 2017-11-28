//
//  MainViewController.swift
//  CustomControllAdvanced-phaydushki
//
//  Created by Petko Haydushki on 23.11.17.
//  Copyright © 2017 Petko Haydushki. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var controllSelectionTableView: UITableView!
    
    
    var data : Array = ["Analog Meter","Percetage meter", "Rings", "Download Button"]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Custom Controlls"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //: MARK - TableView Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (indexPath.row == 0)
        {
            let vc = self.storyboard?.instantiateViewController(withIdentifier:"meterViewController") as! ViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else
        {
            let vc = self.storyboard?.instantiateViewController(withIdentifier:"genericViewController") as! GenericViewController
            vc.item = data[indexPath.row]
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        print("didSelectRowAt \(indexPath)");
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "controllCell", for: indexPath)
        let myItem = data[indexPath.row]
        
        cell.textLabel?.text = myItem
        
        return cell;
    }

    
    

}
