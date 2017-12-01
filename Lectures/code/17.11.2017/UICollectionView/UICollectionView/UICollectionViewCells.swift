//
//  UICollectionViewCells.swift
//  UICollectionView
//
//  Created by Emil Atanasov on 17.11.17.
//  Copyright © 2017 SwiftFMI. All rights reserved.
//

import UIKit

public class TitleCell : UICollectionViewCell {
    @IBOutlet var text:UILabel!
}

public class ImageCell : UICollectionViewCell {
    @IBOutlet var image:UIImageView!
}

public class ButtonCell : UICollectionViewCell {
    @IBOutlet var button:UIButton!
}
