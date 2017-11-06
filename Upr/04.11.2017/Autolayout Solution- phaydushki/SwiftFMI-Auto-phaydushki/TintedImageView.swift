//
//  TintedImageView.swift
//  SwiftFMI-Auto
//
//  Created by Spas Bilyarski on 3.11.17.
//  Copyright © 2017 spasbilyarski. All rights reserved.
//

import UIKit

// IBDesignable ни позволяват да виждаме промените на IBInspectable променливите в Interface Builder
@IBDesignable

class TintedImageView: UIImageView {

    // IBInspectable ни позволяват манипулацията на променливи през Interface Builder
    @IBInspectable var icon: UIImage? = nil {
        didSet {
            image = icon?.withRenderingMode(.alwaysTemplate)
        }
    }

}
