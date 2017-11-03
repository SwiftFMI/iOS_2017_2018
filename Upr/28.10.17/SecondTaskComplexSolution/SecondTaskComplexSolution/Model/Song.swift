//
//  Song.swift
//  SecondTaskComplexSolution
//
//  Created by Petko Haydushki on 31.10.17.
//  Copyright © 2017 Petko Haydushki. All rights reserved.
//

import UIKit

class Song: NSObject {
    
    var name = "";
    var artistName = "";
    var artworkImageName = "";
    
    
    override init() {
        super.init()
    }
    
    init(name : String,artist : String, artwork : String) {
        self.name = name;
        self.artistName = artist;
        self.artworkImageName = artwork;
    }
}
