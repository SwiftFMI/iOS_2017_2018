//
//  FeedViewCell.swift
//  InstagramFeedNativeDemo
//
//  Created by Emil Atanasov on 11.01.18.
//  Copyright © 2018 SwiftFMI. All rights reserved.
//

import UIKit

class FeedViewCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        avatarImage.layer.cornerRadius = avatarImage.frame.height / 2
        avatarImage.clipsToBounds = true
        
    }
    
    // Instance variable:
    var imageAspectRatioConstraint: NSLayoutConstraint?

    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var avatarName: UILabel!
    @IBOutlet weak var image: UIImageView!
}
