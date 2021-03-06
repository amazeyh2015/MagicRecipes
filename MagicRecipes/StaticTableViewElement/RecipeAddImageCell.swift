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
    
    private var backgroundView: UIView!
    private var titleLabel: UILabel!
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .tertiarySystemBackground
        
        backgroundView = UIView()
        backgroundView.backgroundColor = .tertiarySystemFill
        addSubview(backgroundView)
        
        backgroundView.isHidden = true
        
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textColor = .systemBlue
        titleLabel.textAlignment = .center
        titleLabel.text = "添加图片"
        addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            backgroundView.isHidden = false
            UIView.animate(withDuration: 1, animations: { 
                self.backgroundView.alpha = 0
            }) { _ in
                self.backgroundView.isHidden = true
                self.backgroundView.alpha = 1
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundView.frame = bounds
        titleLabel.frame = bounds
    }
}
