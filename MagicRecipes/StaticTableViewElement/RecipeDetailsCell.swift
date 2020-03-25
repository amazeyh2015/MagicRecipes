//
//  RecipeDetailsCell.swift
//  MagicRecipes
//
//  Created by 于涵 on 2020/3/4.
//  Copyright © 2020 yuhan. All rights reserved.
//

import UIKit
import StaticTableView

protocol RecipeDetailsCellDelegate: AnyObject {
    
    func recipeDetailsCell(_ cell: RecipeDetailsCell, detailsDidChange details: String)
    func recipeDetailsCell(_ cell: RecipeDetailsCell, detailsHeightDidChange height: CGFloat)
    func recipeDetailsCellDidBeginEditing(_ cell: RecipeDetailsCell)
    func recipeDetailsCellDidEndEditing(_ cell: RecipeDetailsCell)
}

extension RecipeDetailsCellDelegate {
    
    func recipeDetailsCell(_ cell: RecipeDetailsCell, detailsDidChange details: String) {}
    func recipeDetailsCell(_ cell: RecipeDetailsCell, detailsHeightDidChange height: CGFloat) {}
    func recipeDetailsCellDidBeginEditing(_ cell: RecipeDetailsCell) {}
    func recipeDetailsCellDidEndEditing(_ cell: RecipeDetailsCell) {}
}

class RecipeDetailsCell: StaticTableViewCell {

    private var placeholderLabel: UILabel!
    private var textView: UITextView!
    private var virticalSpace: CGFloat = 15
    
    var details: String = "" {
        didSet {
            textView.text = details
            textViewDidChange(textView)
        }
    }
    
    var detailsRect: CGRect {
        return textView.frame
    }
    
    var isEditing: Bool {
        return textView.isFirstResponder
    }
    
    weak var delegate: RecipeDetailsCellDelegate?
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .tertiarySystemBackground
        preservesSuperviewLayoutMargins = true
        
        placeholderLabel = UILabel()
        placeholderLabel.font = UIFont.systemFont(ofSize: 16)
        placeholderLabel.textColor = UIColor.placeholderText
        placeholderLabel.text = "做法尽可能详细"
        placeholderLabel.sizeToFit()
        addSubview(placeholderLabel)
        
        textView = UITextView()
        textView.frame.size.height = 20
        textView.backgroundColor = UIColor.clear
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textColor = UIColor.label
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = .zero
        textView.delegate = self
        addSubview(textView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func heightInTableView(_ tableView: StaticTableView) -> CGFloat {
        textView.frame.size.width = frame.width - layoutMargins.left - layoutMargins.right
        textView.frame.size.height = textView.contentSize.height
        return textView.frame.height + virticalSpace * 2
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        placeholderLabel.frame.origin.x = layoutMargins.left
        placeholderLabel.frame.origin.y = virticalSpace
        
        textView.frame.origin.x = layoutMargins.left
        textView.frame.origin.y = virticalSpace
    }
}

extension RecipeDetailsCell: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
        guard let delegate = delegate else { return }
        if textView.frame.height != textView.contentSize.height {
            delegate.recipeDetailsCell(self, detailsHeightDidChange: textView.contentSize.height)
        }
        delegate.recipeDetailsCell(self, detailsDidChange: textView.text)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        delegate?.recipeDetailsCellDidBeginEditing(self)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        delegate?.recipeDetailsCellDidEndEditing(self)
    }
}
