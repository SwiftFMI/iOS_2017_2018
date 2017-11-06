//
//  ViewController.swift
//  SecondTaskComplexSolution
//
//  Created by Petko Haydushki on 31.10.17.
//  Copyright © 2017 Petko Haydushki. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var songListTableView: UITableView!
    
    let songManager = SongManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    //: MARK - TableView Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let playVC = self.storyboard?.instantiateViewController(withIdentifier:"playViewController") as! PlayViewController
        
        playVC.currentSong = songManager.data[indexPath.row] as! Song
        
        self.navigationController?.pushViewController(playVC, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        print("didSelectRowAt \(indexPath)");
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songManager.data.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath) as! SongTableViewCell
        let myItem = songManager.data[indexPath.row] as! Song
        
        cell.artistNameLabel.text = myItem.artistName
        cell.songNameLabel.text = myItem.name
        
        cell.artworkImageView.image = UIImage.init(named: myItem.artworkImageName)
        

        return cell;
    }

}

