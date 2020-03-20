//
//  RecipeImagesTableViewCell.swift
//  MagicRecipes
//
//  Created by 于涵 on 2019/12/29.
//  Copyright © 2019 yuhan. All rights reserved.
//

import UIKit

class RecipeImagesTableViewCell: UITableViewCell {

    private var recipeImagesView: RecipeImageCollectionView!
    
    var images: [UIImage] = [] {
        didSet {
            recipeImagesView.images = images
        }
    }
    
    init() {
        super.init(style: .default, reuseIdentifier: nil)
        
        recipeImagesView = RecipeImageCollectionView()
        contentView.addSubview(recipeImagesView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: size.width, height: size.width * 0.75)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        recipeImagesView.frame = contentView.bounds
    }
}
