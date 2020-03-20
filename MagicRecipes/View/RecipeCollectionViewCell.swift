//
//  RecipeCollectionViewCell.swift
//  MagicRecipes
//
//  Created by 于涵 on 2020/3/1.
//  Copyright © 2020 yuhan. All rights reserved.
//

import UIKit

class RecipeCollectionViewCell: UICollectionViewCell {
    
    static let minWidth: CGFloat = 160
    static let nameLabelHeight: CGFloat = 40
    
    private var coverImageView: UIImageView!
    private var nameLabel: UILabel!
    
    var coverImage: UIImage? {
        didSet {
            coverImageView.image = coverImage
        }
    }
    
    var name: String? {
        didSet {
            nameLabel.text = name
        }
    }
    
    var longPressHandler: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        coverImageView = UIImageView()
        coverImageView.backgroundColor = .systemGroupedBackground
        coverImageView.contentMode = .scaleAspectFill
        coverImageView.clipsToBounds = true
        contentView.addSubview(coverImageView)
        
        nameLabel = UILabel()
        nameLabel.frame.size.height = RecipeCollectionViewCell.nameLabelHeight
        nameLabel.font = UIFont.systemFont(ofSize: 16)
        nameLabel.textColor = UIColor.label
        contentView.addSubview(nameLabel)
        
        contentView.addLongPressGestureRecognizer(target: self, action: #selector(contentViewLongPressed(_:)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        coverImageView.image = nil
        nameLabel.text = nil
        longPressHandler = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        coverImageView.frame.size.width = frame.width
        coverImageView.frame.size.height = frame.width
        
        nameLabel.frame.origin.y = coverImageView.frame.maxY
        nameLabel.frame.size.width = frame.width
    }
    
    @objc private func contentViewLongPressed(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            longPressHandler?()
        }
    }
}
