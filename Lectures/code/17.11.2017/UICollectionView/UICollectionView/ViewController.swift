//
//  ViewController.swift
//  UICollectionView
//
//  Created by Emil Atanasov on 17.11.17.
//  Copyright © 2017 SwiftFMI. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource,
UICollectionViewDelegate {
    // MARK: properties
    @IBOutlet weak var viewCollection: UICollectionView!
    var items:[String] = []
    
    // MARK: - UIViewCollection methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //add mock data
        for i in 1 ... 50 {
            items.append("Item #\(i)")
        }
        
        //this is done through the Interface Builder
        //self.viewCollection.dataSource = self
        self.viewCollection.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - UICollectionViewDataSource methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellTypeOne", for: indexPath)
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //because we have no sections
        let item = items[indexPath.row]
        print("\(item) was selected.")
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        //because we have no sections
        let item = items[indexPath.row]
        print("\(item) was deselected.")
    }
}

