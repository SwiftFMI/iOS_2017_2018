//
//  SongManager.swift
//  SecondTaskComplexSolution
//
//  Created by Petko Haydushki on 3.11.17.
//  Copyright © 2017 Petko Haydushki. All rights reserved.
//

import UIKit

class SongManager: NSObject {

    let data : NSMutableArray = []


    override init()
    {
        
        super.init()
        
        let first = Song.init(name: "Shape of you", artist: "Ed Sheran", artwork: "shape")
        let second = Song.init(name: "Panda", artist: "Desiigner", artwork: "panda")
        let third = Song.init(name: "Mask off", artist: "Future", artwork: "mask")
        let fourth = Song.init(name: "Mind", artist: "Skrillex", artwork: "mind")
        
        data.add(first);
        data.add(second);
        data.add(third);
        data.add(fourth);
    }
}
