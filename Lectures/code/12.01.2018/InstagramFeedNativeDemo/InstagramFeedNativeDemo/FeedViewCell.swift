//
//  FeedViewCell.swift
//  InstagramFeedNativeDemo
//
//  Created by Emil Atanasov on 11.01.18.
//  Copyright © 2018 SwiftFMI. All rights reserved.
//

import UIKit

class FeedViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var widthConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let screen = UIScreen.main
        widthConstraint.constant = screen.bounds.width
        
        avatarImage.layer.cornerRadius = avatarImage.frame.height / 2
        avatarImage.clipsToBounds = true
    }
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var avatarName: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet private weak var imageHeightConstraint: NSLayoutConstraint!
    
    var imageDimentions: CGSize = .zero {
        didSet {
            let imageWidth = widthConstraint.constant
            let scaleRatio = imageDimentions.width/imageWidth
            let scaledHeigth = imageDimentions.height/scaleRatio
            
            imageHeightConstraint.constant = scaledHeigth
        }
    }
    
}
