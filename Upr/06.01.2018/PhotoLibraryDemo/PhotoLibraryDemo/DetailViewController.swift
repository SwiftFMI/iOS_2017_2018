//
//  DetailViewController.swift
//  PhotoLibraryDemo
//
//  Created by Dragomir Ivanov on 6.01.18.
//  Copyright © 2018 Swift FMI. All rights reserved.
//

import UIKit

class DetailViewController: UICollectionViewController {

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    var detailItem: Any? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    var itemSize: CGSize?
    
    func initItemSize() {
        guard let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout else  {
            return
        }
        
        let count = CGFloat(4)
        let padding = CGFloat(0.5)
        
        layout.minimumLineSpacing = padding*2
        layout.minimumInteritemSpacing = padding
        
        let size = (view.bounds.width - (padding * (count+1)))/count
        
        itemSize = CGSize(width: size, height: size)
        
        layout.itemSize = itemSize ?? .zero
    
        collectionView?.setCollectionViewLayout(layout, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if itemSize == nil {
            initItemSize()
        }
    }
}

extension DetailViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? PhotoCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
}

