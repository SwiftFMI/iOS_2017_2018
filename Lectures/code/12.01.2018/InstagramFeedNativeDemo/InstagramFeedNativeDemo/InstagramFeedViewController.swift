//
//  InstagramFeedViewController.swift
//  InstagramFeedNativeDemo
//
//  Created by Emil Atanasov on 10.01.18.
//  Copyright © 2018 SwiftFMI. All rights reserved.
//

import UIKit

private let reuseIdentifier = "FeedCell"
public let SERVER_ROOT = "http://192.168.0.108:8888/instagram/"

class InstagramFeedViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var model:[FeedItem]?
    var urlSession:URLSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(FeedViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        collectionView?.delegate = self
        
//        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
//            flowLayout.itemSize = CGSize(width: 1, height: 1)
//        }
        loadData()
    }
    
    func loadData() {
        urlSession = URLSession.shared
        
        //json path
        let jsonURL = SERVER_ROOT + "instagramdemofeed.json"
        let rq = URLRequest(url: URL(string:jsonURL)!)
        urlSession?.dataTask(with: rq, completionHandler: { [weak self] (data, response, error) in
            print(data ?? "no data")
            print(response ?? "no response")
            print(error ?? "no error")
            
            
            let decoder = JSONDecoder()
            let feed = try! decoder.decode([FeedItem].self, from: data!)
            
            DispatchQueue.main.async { [weak self] in 
                self?.update(feed:feed)
            }
            
        }).resume()
    }
    
    func update(feed:[FeedItem]?) {
        model = feed
        // refresh the view
        collectionView?.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return model?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedViewCell
    
        // Configure the cell
        let feed = model?[indexPath.row]
        
        cell.avatarName.text = feed?.avatar?.name
        if let image = feed?.image {
            let url = URL(string:SERVER_ROOT + image)
            //don't load images like this
            //use async loading and caching
            let imageData:Data = try! Data.init(contentsOf: url!, options: Data.ReadingOptions.mappedIfSafe)
            let img = UIImage(data:imageData)
            cell.image.image = img

//            cell.imageAspectRatioConstraint?.isActive = false
//            cell.imageAspectRatioConstraint = cell.image.widthAnchor.constraint(
//                equalTo: cell.image.heightAnchor,
//                multiplier: cell.image.image!.size.width / cell.image.image!.size.height)
//            cell.imageAspectRatioConstraint!.isActive = true
            
            
//            cell.image.image = img
//            cell.image.layoutIfNeeded()
            
        }
        
        if let avatarImage = feed?.avatar?.url {
            let url = URL(string:SERVER_ROOT + avatarImage)
            //don't load images like this
            //use async loading and caching
            let imageData:Data = try! Data.init(contentsOf: url!, options: Data.ReadingOptions.mappedIfSafe)
            
            cell.avatarImage.image = UIImage(data:imageData)
            
        }
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    
    //MARK : item size
//    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.width, height: collectionView.frame.width)
//    }
}
