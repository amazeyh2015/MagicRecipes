//
//  RecipeImageCell.swift
//  MagicRecipes
//
//  Created by 于涵 on 2020/3/4.
//  Copyright © 2020 yuhan. All rights reserved.
//

import UIKit
import StaticTableView

class RecipeImageCell: StaticTableViewCell {
    
    var coverImage: UIImage? {
        didSet {
            imageView?.image = coverImage
        }
    }
    
    init() {
        super.init(style: .default, reuseIdentifier: nil)
        
        imageView?.contentMode = .scaleAspectFill
        imageView?.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: size.width, height: size.width)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView?.frame = contentView.bounds
    }
}
