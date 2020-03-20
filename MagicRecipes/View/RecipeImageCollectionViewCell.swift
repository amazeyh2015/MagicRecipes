//
//  RecipeImageCollectionViewCell.swift
//  MagicRecipes
//
//  Created by 于涵 on 2019/11/24.
//  Copyright © 2019 yuhan. All rights reserved.
//

import UIKit

class RecipeImageCollectionViewCell: UICollectionViewCell {
    
    private var imageView: UIImageView!

    var image: UIImage! {
        didSet {
            imageView.image = image
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
}
