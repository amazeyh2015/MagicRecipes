//
//  RecipeDisplayImagesCell.swift
//  MagicRecipes
//
//  Created by 于涵 on 2020/3/6.
//  Copyright © 2020 yuhan. All rights reserved.
//

import UIKit
import StaticTableView

class RecipeDisplayImagesCell: StaticTableViewCell {
    
    private var imageView: UIImageView!
    
    var images: [UIImage] = [] {
        didSet {
            imageView.image = images.first
        }
    }
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .systemBackground
        
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func heightInTableView(_ tableView: StaticTableView) -> CGFloat {
        let width = frame.width - safeAreaInsets.left - safeAreaInsets.right
        imageView.frame.size = CGSize(width: width, height: width)
        return imageView.frame.height
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame.origin.x = safeAreaInsets.left
    }
}
