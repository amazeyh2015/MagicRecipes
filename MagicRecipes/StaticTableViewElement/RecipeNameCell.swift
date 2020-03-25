//
//  RecipeNameCell.swift
//  MagicRecipes
//
//  Created by 于涵 on 2019/11/2.
//  Copyright © 2019 yuhan. All rights reserved.
//

import UIKit
import StaticTableView

protocol RecipeNameCellDelegate: AnyObject {
    
    func recipeNameCell(_ cell: RecipeNameCell, nameDidChange name: String?)
}

class RecipeNameCell: StaticTableViewCell {
    
    private var textField: UITextField!
    
    var name: String = "" {
        didSet {
            textField.text = name
        }
    }
    
    weak var delegate: RecipeNameCellDelegate?
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .systemBackground
        preservesSuperviewLayoutMargins = true
        
        textField = UITextField()
        textField.frame.size.height = 50
        textField.placeholder = "名字尽可能简洁"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = UIColor.label
        textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        addSubview(textField)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func heightInTableView(_ tableView: StaticTableView) -> CGFloat {
        return textField.frame.height
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textField.frame.origin.x = layoutMargins.left
        textField.frame.size.width = frame.width - layoutMargins.left - layoutMargins.right
    }
    
    @objc private func textFieldEditingChanged() {
        delegate?.recipeNameCell(self, nameDidChange: textField.text)
    }
}
