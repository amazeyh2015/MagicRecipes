//
//  RecipeListLayout.swift
//  MagicRecipes
//
//  Created by 于涵 on 2020/3/1.
//  Copyright © 2020 yuhan. All rights reserved.
//

import UIKit

class RecipeListLayout: UICollectionViewFlowLayout {
    
    var layoutMargins: UIEdgeInsets = .zero
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        // get attributes
        guard let original = super.layoutAttributesForElements(in: rect) else {
            return nil
        }
        // copy attributes
        guard let attributes = NSArray(array: original, copyItems: true) as? [UICollectionViewLayoutAttributes] else {
            return nil
        }
        // left alignment
        var previous: UICollectionViewLayoutAttributes?
        for current in attributes {
            if let previous = previous, current.frame.minY == previous.frame.minY {
                current.frame.origin.x = previous.frame.maxX + minimumInteritemSpacing
            } else {
                current.frame.origin.x = layoutMargins.left
            }
            previous = current
        }
        return attributes
    }
}
