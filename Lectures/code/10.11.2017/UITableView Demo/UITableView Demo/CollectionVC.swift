//
//  CollectionVC.swift
//  UITableView Demo
//
//  Created by Emil Atanasov on 11/10/17.
//  Copyright © 2017 SwiftFMI. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet var collectionView:UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 1...50 {
            items.append("New Item \(i)")
        }
        
        collectionView.dataSource = self
    }
    
    //:MARK dataSource
    
    var items:[String] = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCollectionCell", for: indexPath)
        
        return cell
    }
}
