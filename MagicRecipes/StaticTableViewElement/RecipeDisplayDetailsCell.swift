//
//  RecipeDisplayDetailsCell.swift
//  MagicRecipes
//
//  Created by 于涵 on 2020/3/6.
//  Copyright © 2020 yuhan. All rights reserved.
//

import UIKit
import StaticTableView

class RecipeDisplayDetailsCell: StaticTableViewCell {
    
    var details: String = "" {
        didSet {
            textLabel?.text = details
        }
    }
    
    init() {
        super.init(style: .default, reuseIdentifier: nil)
        selectionStyle = .none
        
        textLabel?.font = UIFont.systemFont(ofSize: 16)
        textLabel?.textColor = .label
        textLabel?.numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
