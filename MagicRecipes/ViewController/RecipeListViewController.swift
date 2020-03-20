//
//  RecipeListViewController.swift
//  MagicRecipes
//
//  Created by 于涵 on 2019/11/2.
//  Copyright © 2019 yuhan. All rights reserved.
//

import UIKit

class RecipeListViewController: UIViewController {
    
    private var recipeListLayout: RecipeListLayout!
    private var collectionView: UICollectionView!
    private var recipes: [Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "菜谱"
        navigationItem.rightBarButtonItem = UIBarButtonItem.add(target: self, action: #selector(addButtonClicked))
        navigationItem.backBarButtonItem = UIBarButtonItem.back()
        
        recipeListLayout = RecipeListLayout()
        recipeListLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: recipeListLayout)
        collectionView.backgroundColor = .white
        collectionView.register(RecipeCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        collectionView.edges(equalTo: view)
        
        NotificationCenter.default.addObserver(self, selector: #selector(recipesDidUpdate), name: .RecipesDidUpdate, object: nil)
        
        loadRecipes()
    }
    
    func loadRecipes() {
        RecipeStore.loadRecipes()
    }
    
    @objc func recipesDidUpdate() {
        recipes = RecipeStore.recipes
        collectionView.reloadData()
    }
    
    @objc func addButtonClicked() {
        let vc = RecipeEditViewController()
        let nc = UINavigationController(rootViewController: vc)
        present(nc, animated: true, completion: nil)
    }
    
    private func showDeleteRecipeAlert(_ recipe: Recipe) {
        let ac = UIAlertController(title: "是否删除此菜谱", message: nil, preferredStyle: .alert)
        ac.addAction(title: "取消", style: .cancel, handler: nil)
        ac.addAction(title: "删除", style: .destructive) { _ in
            self.deleteRecipe(recipe)
        }
        present(ac, animated: true, completion: nil)
    }
    
    private func deleteRecipe(_ recipe: Recipe) {
        RecipeStore.deleteRecipe(recipe)
    }
}

extension RecipeListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! RecipeCollectionViewCell
        
        let recipe = recipes[indexPath.row]
        cell.name = recipe.name
        if let imageURL = recipe.imageURLs.first {
            ImageManager.shared.loadImage(at: imageURL) { (_, image, _) in
                cell.coverImage = image
            }
        }
        cell.longPressHandler = { [unowned self] in 
            self.showDeleteRecipeAlert(recipe)
        }
        
        return cell
    }
}

extension RecipeListViewController: UICollectionViewDelegateFlowLayout {
    
    func calculateCellWidth(width: CGFloat, minWidth: CGFloat, space: CGFloat, count: Int, flag: Bool = false) -> CGFloat {
        if count <= 1 {
            return width
        }
        let cellWidth = (width - CGFloat(count - 1) * space) / CGFloat(count)
        if cellWidth < minWidth {
            return calculateCellWidth(width: width, minWidth: minWidth, space: space, count: count - 1, flag: true)
        }
        if flag {
            return cellWidth
        }
        return calculateCellWidth(width: width, minWidth: minWidth, space: space, count: count + 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        recipeListLayout.layoutMargins = collectionView.safeAreaInsets + recipeListLayout.sectionInset
        let width = collectionView.frame.width - recipeListLayout.layoutMargins.left - recipeListLayout.layoutMargins.right
        let minWidth = RecipeCollectionViewCell.minWidth
        let space = recipeListLayout.minimumInteritemSpacing
        let cellWidth = calculateCellWidth(width: width, minWidth: minWidth, space: space, count: 2)
        let cellSize = CGSize(width: cellWidth, height: cellWidth + RecipeCollectionViewCell.nameLabelHeight)
        return cellSize
    }
}

extension RecipeListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipe = recipes[indexPath.row]
        
        let vc = RecipeDetailViewController(recipe: recipe)
        navigationController?.pushViewController(vc, animated: true)
    }
}
