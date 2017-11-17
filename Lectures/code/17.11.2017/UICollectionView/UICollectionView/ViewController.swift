//
//  ViewController.swift
//  UICollectionView
//
//  Created by Emil Atanasov on 17.11.17.
//  Copyright © 2017 SwiftFMI. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate {
    // MARK: properties
    @IBOutlet weak var viewCollection: UICollectionView!
    var dataSource:EmojiDataSource?
    
    // MARK: - UIViewCollection methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //add mock data
        self.dataSource = EmojiDataSource(items: EmojiCollection.emojis)
        
        self.viewCollection.dataSource = self.dataSource
        self.viewCollection.delegate = self
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 166, height: 190)
        
        self.viewCollection.collectionViewLayout = flowLayout
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = dataSource?.get(itemAt:indexPath) {
            print("\(item) was selected.")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let item = dataSource?.get(itemAt:indexPath) {
            print("\(item) was deselected.")
        }
    }
}

