//
//  ScrollViewController.swift
//  UICollectionView
//
//  Created by Emil Atanasov on 18.11.17.
//  Copyright © 2017 SwiftFMI. All rights reserved.
//

import UIKit

public class ScrollViewController : UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var imageView: UIImageView!
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollView.contentSize = CGSize(width: 500, height: 500)
        self.scrollView.minimumZoomScale = 0.2
        self.scrollView.maximumZoomScale = 2
        self.scrollView.delegate = self
        
        
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("Content offset: \(scrollView.contentOffset)")
    }

    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
}
