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
        
        let hexagon = UICollectionViewFlowLayout()
        hexagon.itemSize = CGSize(width: 160, height:90)
//        hexagon.sectionInset = UIEdgeInsets.zero
//        hexagon.headerReferenceSize = CGSize.zero
//        hexagon.footerReferenceSize = CGSize.zero
        hexagon.scrollDirection = .vertical
        

        
        if #available(iOS 10.0, *) {
            let refreshControl = UIRefreshControl()
            let title = NSLocalizedString("PullToRefresh", comment: "Pull to refresh")
            refreshControl.attributedTitle = NSAttributedString(string: title)
            refreshControl.addTarget(self,
                                     action: #selector(refreshOptions(sender:)),
                                     for: .valueChanged)
            self.viewCollection.refreshControl = refreshControl
        }
        
        
        self.viewCollection.collectionViewLayout = hexagon
    }
    
    @objc func refreshOptions(sender:UIRefreshControl) {
        print("refresh")
        sender.endRefreshing()
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

