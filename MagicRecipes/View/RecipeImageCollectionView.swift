//
//  RecipeImageCollectionView.swift
//  MagicRecipes
//
//  Created by 于涵 on 2019/11/24.
//  Copyright © 2019 yuhan. All rights reserved.
//

import UIKit

class RecipeImageCollectionView: UICollectionView {
    
    var images: [UIImage] = [] {
        didSet {
            reloadData()
        }
    }

    init() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        super.init(frame: .zero, collectionViewLayout: flowLayout)
        
        isPagingEnabled = true
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        
        register(RecipeImageCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        dataSource = self
        delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RecipeImageCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! RecipeImageCollectionViewCell
        
        cell.image = images[indexPath.row]
        
        return cell
    }
}

extension RecipeImageCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return frame.size
    }
}
