//
//  RecipeAddImageCell.swift
//  MagicRecipes
//
//  Created by 于涵 on 2020/3/2.
//  Copyright © 2020 yuhan. All rights reserved.
//

import UIKit
import StaticTableView

class RecipeAddImageCell: StaticTableViewCell {
    
    init() {
        super.init(style: .default, reuseIdentifier: nil)
        
        textLabel?.font = UIFont.systemFont(ofSize: 16)
        textLabel?.textColor = .systemBlue
        textLabel?.textAlignment = .center
        textLabel?.text = "添加图片"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: size.width, height: 50)
    }
}
