//
//  RecipeImagesCell.swift
//  MagicRecipes
//
//  Created by 于涵 on 2020/3/2.
//  Copyright © 2020 yuhan. All rights reserved.
//

import UIKit
import StaticTableView

protocol RecipeImagesCellDelegate: AnyObject {
    
    func recipeImagesCell(_ cell: RecipeImagesCell, didTapImage image: UIImage, atIndex index: Int)
    func recipeImagesCell(_ cell: RecipeImagesCell, didLongPressImage image: UIImage, atIndex index: Int)
}

class RecipeImagesCell: StaticTableViewCell {
    
    private var scrollView: UIScrollView!
    private var imageViews: [UIImageView] = []
    private var imageSpace: CGFloat = 10
    private var virticalSpace: CGFloat = 15
    
    let maxImagesCount: Int = 3
    
    weak var delegate: RecipeImagesCellDelegate?
    
    var images: [UIImage] = [] {
        didSet {
            updateImageViews()
        }
    }
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .systemBackground
        preservesSuperviewLayoutMargins = true
        
        scrollView = UIScrollView()
        scrollView.frame.size.height = 160
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize.height = scrollView.frame.height
        addSubview(scrollView)
        
        for _ in 0...maxImagesCount {
            let imageView = UIImageView()
            imageView.frame.origin.x = imageViews.isEmpty ? 0 : (imageViews.last!.frame.maxX + imageSpace)
            imageView.frame.size.width = scrollView.frame.height
            imageView.frame.size.height = scrollView.frame.height
            imageView.backgroundColor = .systemGroupedBackground
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.addTapGestureRecognizer(target: self, action: #selector(imageViewTapped(_:)))
            imageView.addLongPressGestureRecognizer(target: self, action: #selector(imageViewLongPressed(_:)))
            scrollView.addSubview(imageView)
            imageViews.append(imageView)
        }
        
        updateImageViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateImageViews() {
        for (index, imageView) in imageViews.enumerated() {
            if index < images.count {
                imageView.image = images[index]
                imageView.isHidden = false
                scrollView.contentSize.width = imageView.frame.maxX
            } else {
                imageView.isHidden = true
                imageView.image = nil
            }
        }
    }
    
    override func heightInTableView(_ tableView: StaticTableView) -> CGFloat {
        return scrollView.frame.height + virticalSpace * 2
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        scrollView.frame.origin.x = layoutMargins.left
        scrollView.frame.origin.y = virticalSpace
        scrollView.frame.size.width = frame.width - layoutMargins.left - layoutMargins.right
    }
    
    @objc func imageViewTapped(_ sender: UITapGestureRecognizer) {
        guard let imageView = sender.view as? UIImageView, let image = imageView.image else {
            return
        }
        guard let index = imageViews.firstIndex(of: imageView) else {
            return
        }
        delegate?.recipeImagesCell(self, didTapImage: image, atIndex: index)
    }
    
    @objc func imageViewLongPressed(_ sender: UILongPressGestureRecognizer) {
        if sender.state != .began {
            return
        }
        guard let imageView = sender.view as? UIImageView, let image = imageView.image else {
            return
        }
        guard let index = imageViews.firstIndex(of: imageView) else {
            return
        }
        delegate?.recipeImagesCell(self, didLongPressImage: image, atIndex: index)
    }
}
