//
//  PBJHexagonFlowLayout.swift
//  UICollectionView
//
// Port of https://github.com/piemonte/PBJHexagon/blob/master/Source/PBJHexagonFlowLayout.m
//
//  Created by Emil Atanasov on 17.11.17.
//  Copyright © 2017 SwiftFMI. All rights reserved.
//

import UIKit

public class PBJHexagonFlowLayout: UICollectionViewFlowLayout {
    var itemsPerRow = 4
    
    public init(itemsPerRow:Int) {
        super.init()
        self.itemsPerRow = itemsPerRow
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public override func prepare() {
        super.prepare()
        
        if itemsPerRow <= 0 {
            itemsPerRow = 4
        }
    }
    
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes:[UICollectionViewLayoutAttributes]? = []
        let numberOfItems = (self.collectionView?.numberOfItems(inSection: 0))! - 1
        
        for i in 0...numberOfItems {
            let indexPath = IndexPath(item: i, section: 0  )
            
            layoutAttributes?.append(self.layoutAttributesForItem(at: indexPath)!)
        }
        return layoutAttributes
    }
    
    public override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let row = Int(floor(Double(indexPath.row) / Double(itemsPerRow) ))
        let col = indexPath.row % itemsPerRow
        
        let horiOffset = ((row % 2) != 0) ? 0 : self.itemSize.width * 0.5
        let vertOffset = 0
        
        let attributes = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
        attributes.size = self.itemSize
        let centerX = (Double(col) * Double(self.itemSize.width)) + (0.5 * Double(self.itemSize.width)) + Double(horiOffset)
        let centerY = Double(row) * 0.75 * Double(self.itemSize.height) + 0.5 * Double(self.itemSize.height) + Double(vertOffset)
        attributes.center = CGPoint( x: centerX, y: centerY)
        return attributes;
    }
    
    
    
    public override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return false
    }
    
    public override var collectionViewContentSize: CGSize {

        
        let numberOfItems = (self.collectionView?.numberOfItems(inSection: 0))!
        
        let contentWidth = Double(self.collectionView?.bounds.size.width ?? 0)
        let contentHeight = ( (Double(numberOfItems) / Double(itemsPerRow) * 0.75) * Double(self.itemSize.height)) + (0.5 + Double(self.itemSize.height))
        
        let contentSize = CGSize(width:contentWidth, height: contentHeight)
        return contentSize
        
    }
}
