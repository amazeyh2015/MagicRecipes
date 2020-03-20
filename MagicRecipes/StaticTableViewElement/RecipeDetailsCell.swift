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
}

class RecipeDetailsCell: StaticTableViewCell {

    private var placeholderLabel: UILabel!
    private var textView: UITextView!
    private var virticalSpace: CGFloat = 15
    
    var details: String = "" {
        didSet {
            textView.text = details
            placeholderLabel.isHidden = !details.isEmpty
        }
    }
    
    weak var delegate: RecipeDetailsCellDelegate?
    
    init() {
        super.init(style: .default, reuseIdentifier: nil)
        selectionStyle = .none
        
        placeholderLabel = UILabel()
        placeholderLabel.font = UIFont.systemFont(ofSize: 16)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.text = "做法尽可能详细"
        placeholderLabel.sizeToFit()
        contentView.addSubview(placeholderLabel)
        
        textView = UITextView()
        textView.frame.size.height = 300
        textView.backgroundColor = UIColor.clear
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textColor = UIColor.black
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = .zero
        textView.delegate = self
        contentView.addSubview(textView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
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
        textView.frame.size.width = frame.width - layoutMargins.left - layoutMargins.right
    }
}

extension RecipeDetailsCell: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
        delegate?.recipeDetailsCell(self, detailsDidChange: textView.text)
    }
}
