//
//  DataSource.swift
//  UICollectionView
//
//  Created by Emil Atanasov on 17.11.17.
//  Copyright © 2017 SwiftFMI. All rights reserved.
//

import UIKit

//custom data source 
public class MyCustomDataSource:NSObject, UICollectionViewDataSource {
    
    var items:[String]
    init(items:[String]) {
        self.items = items
    }
    
    init(items:Int) {
        self.items = []
        if items > 1 {
            for i in 1 ... items {
                self.items.append("Mock Item #\(i)")
            }
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellTypeOne", for: indexPath)
        
        return cell
    }
    
    public func get(itemAt indexPath:IndexPath) -> String {
        let item = self.items[indexPath.row]
        return item
    }
    
}
