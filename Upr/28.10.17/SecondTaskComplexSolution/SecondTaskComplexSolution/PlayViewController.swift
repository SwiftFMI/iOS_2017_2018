//
//  PlayViewController.swift
//  SecondTaskComplexSolution
//
//  Created by Petko Haydushki on 2.11.17.
//  Copyright © 2017 Petko Haydushki. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox


class PlayViewController: UIViewController {
    
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!

    @IBOutlet weak var playPauseButton: UIButton!

    @IBOutlet weak var volumeSlider: UISlider!
    

    var currentSong : Song = Song()
    var playing : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Now Playing"

        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "Back", style: UIBarButtonItemStyle.done, target: self, action: #selector(back))
        
        self.songNameLabel.text? = currentSong.name
        self.artistNameLabel.text? = currentSong.artistName;
        self.artworkImageView.image = UIImage(named: currentSong.artworkImageName)
        // Do any additional setup after loading the view.
    }

    @objc func back() -> Void {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func playPauseButtonAction(_ sender: Any) {
       
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        playing = !playing
        if (playing)
        {
            let soundFile = Bundle.main.path(forResource: currentSong.artworkImageName, ofType: "mp3")
            let url = URL(fileURLWithPath: soundFile!)
            appDelegate.mAudioPlayer = try! AVAudioPlayer(contentsOf: url as URL)
            appDelegate.mAudioPlayer?.play()
            
            playPauseButton.setImage(UIImage.init(named: "pause"), for: UIControlState.normal)
        }
        else
        {
            appDelegate.mAudioPlayer?.pause();
            
            self.playPauseButton.setImage(UIImage.init(named: "play"), for: UIControlState.normal)
        }
    }
    @IBAction func previousTrackButtonAction(_ sender: Any) {
    }
    @IBAction func nextTrackButtonAction(_ sender: Any) {
    }
    
    @IBAction func volumeChanged(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.mAudioPlayer?.setVolume(self.volumeSlider.value, fadeDuration: 0.1)
    }
}
