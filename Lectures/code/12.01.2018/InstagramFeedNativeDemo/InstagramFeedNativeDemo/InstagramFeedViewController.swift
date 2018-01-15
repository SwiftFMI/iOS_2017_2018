//
//  InstagramFeedViewController.swift
//  InstagramFeedNativeDemo
//
//  Created by Emil Atanasov on 10.01.18.
//  Copyright © 2018 SwiftFMI. All rights reserved.
//

import UIKit

private let reuseIdentifier = "FeedCell"
public let SERVER_ROOT = "http://10.83.76.160:8888/instagram/"

class InstagramFeedViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var model:[FeedItem]?
    var urlSession:URLSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let cellNib = UINib(nibName: "FeedViewCell", bundle: nil)
        collectionView?.register(cellNib, forCellWithReuseIdentifier: reuseIdentifier)
        
        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = CGSize(width: 1, height: 1)
        }

        loadData()
    }
    
    func loadData() {
        //json path
        let urlString = SERVER_ROOT + "instagramdemofeed.json"
        guard let serverURL = URL(string: urlString) else { return }
        
        let rq = URLRequest(url: serverURL)
        urlSession = URLSession.shared
        
        urlSession?.dataTask(with: rq, completionHandler: { [weak self] (data, response, error) in
            guard error == nil else { print(error!); return }
            guard response != nil else { print("no response"); return }
            guard let data = data else { print("no data"); return }
            
            do {
                let feed = try JSONDecoder().decode([FeedItem].self, from: data)
                
                DispatchQueue.main.async { [weak self] in
                    self?.update(feed:feed)
                }
            } catch (let err) {
                print(err)
            }

        }).resume()
    }
    
    func update(feed:[FeedItem]?) {
        model = feed
        // refresh the view
        collectionView?.reloadData()
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? FeedViewCell else {
            return UICollectionViewCell()
        }
        
        guard let feedModel = model?[indexPath.row] else {
            return cell
        }
        // Configure the cell
        cell.avatarName.text = feedModel.avatar?.name
        
        if let image = feedModel.image {
            let url = URL(string:SERVER_ROOT + image)
            //don't load images like this
            //use async loading and caching
            let imageData:Data = try! Data.init(contentsOf: url!, options: Data.ReadingOptions.mappedIfSafe)
            let img = UIImage(data:imageData)
            cell.image.image = img
        }
        
        if let avatarImage = feedModel.avatar?.url {
            let url = URL(string:SERVER_ROOT + avatarImage)
            //don't load images like this
            //use async loading and caching
            let imageData:Data = try! Data.init(contentsOf: url!, options: Data.ReadingOptions.mappedIfSafe)
            
            cell.avatarImage.image = UIImage(data:imageData)
        }
        
        if let width = feedModel.imageWidth, let height = feedModel.imageHeight {
            cell.imageDimentions = CGSize(width: width, height: height)
        } else {
            cell.imageDimentions = CGSize(width: UIScreen.main.bounds.width, height: 250)
        }
        
        return cell
    }
}
