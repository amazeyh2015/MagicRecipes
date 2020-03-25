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
    
    private var detailsLabel: UILabel!
    private var virticalSpace: CGFloat = 15
    
    var details: String = "" {
        didSet {
            detailsLabel.text = details
        }
    }
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .systemBackground
        preservesSuperviewLayoutMargins = true
        
        detailsLabel = UILabel()
        detailsLabel.font = UIFont.systemFont(ofSize: 16)
        detailsLabel.textColor = .label
        detailsLabel.numberOfLines = 0
        addSubview(detailsLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func heightInTableView(_ tableView: StaticTableView) -> CGFloat {
        let maxDetailsLabelWidth = frame.width - layoutMargins.left - layoutMargins.right
        let maxDetailsLabelSize = CGSize(width: maxDetailsLabelWidth, height: 9999)
        detailsLabel.frame.size = detailsLabel.sizeThatFits(maxDetailsLabelSize)
        return detailsLabel.frame.height + virticalSpace * 2
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        detailsLabel.frame.origin.x = layoutMargins.left
        detailsLabel.frame.origin.y = virticalSpace
    }
}
