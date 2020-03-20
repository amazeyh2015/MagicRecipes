//
//  RecipeHeaderView.swift
//  MagicRecipes
//
//  Created by 于涵 on 2020/3/2.
//  Copyright © 2020 yuhan. All rights reserved.
//

import UIKit
import StaticTableView

class RecipeHeaderView: StaticTableViewHeader {
    
    private var titleLabel: UILabel!
    private let topSpace: CGFloat = 15
    private let virticalSpace: CGFloat = 6
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    init() {
        super.init(frame: .zero)
        
        preservesSuperviewLayoutMargins = true
        
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textColor = UIColor.darkGray
        titleLabel.numberOfLines = 0
        addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func height(in tableView: UITableView) -> CGFloat {
        let tableViewWidth = tableView.frame.width
        let layoutMargins = tableView.layoutMargins
        let titleLabelMaxWidth = tableViewWidth - layoutMargins.left - layoutMargins.right
        let titleLabelMaxSize = CGSize(width: titleLabelMaxWidth, height: 999)
        titleLabel.frame.size = titleLabel.sizeThatFits(titleLabelMaxSize)
        let height = titleLabel.frame.height + virticalSpace * 2 + topSpace
        return height
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.frame.origin.x = layoutMargins.left
        titleLabel.frame.origin.y = virticalSpace + topSpace
    }
}
