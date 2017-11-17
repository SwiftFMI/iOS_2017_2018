//
//  ViewController.swift
//  UICollectionView
//
//  Created by Emil Atanasov on 17.11.17.
//  Copyright © 2017 SwiftFMI. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource {

    @IBOutlet weak var viewCollection: UICollectionView!
    var items:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //add mock data
        for i in 1 ... 5 {
            items.append("Item #\(i)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // :MARK UICollectionViewDataSource methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellTypeOne", for: indexPath)
        
        return cell
    }
}

