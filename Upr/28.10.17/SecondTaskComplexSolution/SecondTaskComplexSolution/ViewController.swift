//
//  ViewController.swift
//  SecondTaskComplexSolution
//
//  Created by Petko Haydushki on 31.10.17.
//  Copyright © 2017 Petko Haydushki. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    


    @IBOutlet weak var songListTableView: UITableView!
    let data : NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let first = Song.init(name: "Shape of you", artist: "Ed Sheran", artwork: "shape")
        let second = Song.init(name: "Panda", artist: "Desiigner", artwork: "panda")
        let third = Song.init(name: "Mask off", artist: "Future", artwork: "mask")
        let fourth = Song.init(name: "Mind", artist: "Skrillex", artwork: "mind")
        
        data.add(first);
        data.add(second);
        data.add(third);
        data.add(fourth);
        // Do any additional setup after loading the view, typically from a nib.
    }

    //: MARK - TableView Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let playVC = self.storyboard?.instantiateViewController(withIdentifier:"playViewController") as! PlayViewController
        
        playVC.currentSong = data[indexPath.row] as! Song
        
        self.navigationController?.pushViewController(playVC, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        print("didSelectRowAt \(indexPath)");
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath) as! SongTableViewCell
        let myItem = data[indexPath.row] as! Song
        
        cell.artistNameLabel.text = myItem.artistName
        cell.songNameLabel.text = myItem.name
        
        cell.artworkImageView.image = UIImage.init(named: myItem.artworkImageName)
        

        return cell;
    }

}

