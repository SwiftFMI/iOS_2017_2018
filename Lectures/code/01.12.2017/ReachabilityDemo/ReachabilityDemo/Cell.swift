//
//  Cell.swift
//  ReachabilityDemo
//
//  Created by Emil Atanasov on 2.12.17.
//  Copyright © 2017 SwiftFMI. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class MyCellNode: ASCellNode {
    let loader = SpinnerNode()
    let text = ASTextNode()
    
    override init() {
        super.init()
        
        addSubnode(text)
        text.attributedText = NSAttributedString(
            string: "Loading…",
            attributes: [
                NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12),
                NSAttributedStringKey.foregroundColor: UIColor.lightGray,
                NSAttributedStringKey.kern: -0.3
            ])
        addSubnode(loader)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        return ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 16,
            justifyContent: .center,
            alignItems: .center,
            children: [ text, loader ])
    }
}

class SpinnerNode: ASDisplayNode {
    var activityIndicatorView: UIActivityIndicatorView {
        return view as! UIActivityIndicatorView
    }
    
    override init() {
        super.init()
        setViewBlock {
            UIActivityIndicatorView(activityIndicatorStyle: .gray)
        }
        
        // Set spinner node to default size of the activitiy indicator view
        self.style.preferredSize = CGSize(width: 30.0, height: 30.0)
    }
    
    override func didLoad() {
        super.didLoad()
        
        activityIndicatorView.startAnimating()
    }
}
