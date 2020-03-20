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
        let origin = textView.frame.origin
        let size = textView.contentSize
        return CGRect(origin: origin, size: size)
    }
    
    weak var delegate: RecipeDetailsCellDelegate?
    
    init() {
        super.init(style: .default, reuseIdentifier: nil)
        selectionStyle = .none
        
        placeholderLabel = UILabel()
        placeholderLabel.font = UIFont.systemFont(ofSize: 16)
        placeholderLabel.textColor = UIColor.placeholderText
        placeholderLabel.text = "做法尽可能详细"
        placeholderLabel.sizeToFit()
        contentView.addSubview(placeholderLabel)
        
        textView = UITextView()
        textView.backgroundColor = UIColor.clear
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textColor = UIColor.label
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = .zero
        textView.delegate = self
        contentView.addSubview(textView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sizeToFit() {
        frame.size.height = textView.frame.maxY + virticalSpace
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let layoutMargins = contentView.layoutMargins
        textView.frame.size.width = contentView.frame.width - layoutMargins.left - layoutMargins.right
        textView.frame.size.height = textView.contentSize.height
        let height = textView.frame.height + virticalSpace * 2
        return CGSize(width: size.width, height: height)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layoutMargins = contentView.layoutMargins
        
        placeholderLabel.frame.origin.x = layoutMargins.left
        placeholderLabel.frame.origin.y = virticalSpace
        
        textView.frame.origin.x = layoutMargins.left
        textView.frame.origin.y = virticalSpace
    }
    
    private func updateTextViewHeight() {
        if textView.frame.height != textView.contentSize.height {
            textView.frame.size.height = textView.contentSize.height
            delegate?.recipeDetailsCell(self, detailsHeightDidChange: textView.frame.height)
        }
    }
    
    private func updatePlaceholderLabelStatus() {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
}

extension RecipeDetailsCell: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        updatePlaceholderLabelStatus()
        updateTextViewHeight()
        delegate?.recipeDetailsCell(self, detailsDidChange: textView.text)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        delegate?.recipeDetailsCellDidBeginEditing(self)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        delegate?.recipeDetailsCellDidEndEditing(self)
    }
}
