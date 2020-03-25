//
//  RecipeDetailViewController.swift
//  MagicRecipes
//
//  Created by 于涵 on 2019/11/2.
//  Copyright © 2019 yuhan. All rights reserved.
//

import UIKit
import StaticTableView

class RecipeDetailViewController: BaseViewController {
    
    private var imagesCell: RecipeDisplayImagesCell!
    private var detailsCell: RecipeDisplayDetailsCell!
    private var tableView: StaticTableView!
    
    private var recipe: Recipe
    
    init(recipe: Recipe) {
        self.recipe = recipe
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = recipe.name
        navigationItem.rightBarButtonItem = UIBarButtonItem.edit(target: self, action: #selector(editButtonClicked))
        
        imagesCell = RecipeDisplayImagesCell()
        updateImagesCellContent()
        
        detailsCell = RecipeDisplayDetailsCell()
        updateDetailsCellContent()
        
        tableView = StaticTableView()
        tableView.sections = makeSections()
        view.addSubview(tableView)
        
        tableView.edges(equalTo: view)
         
        NotificationCenter.default.addObserver(self, selector: #selector(recipeDidUpdate(_:)), name: .RecipeDidUpdate, object: nil)
    }
    
    private func updateImagesCellContent() {
        ImageManager.shared.loadImage(at: recipe.imageURLs.first) { (_, image, _) in
            if let image = image {
                self.imagesCell.images = [image]
            }
        }
    }
    
    private func updateDetailsCellContent() {
        if recipe.details.isEmpty {
            detailsCell.details = "该菜谱还没有添加做法"
        } else {
            detailsCell.details = recipe.details
        }
    }
    
    @objc func editButtonClicked() {
        let vc = RecipeEditViewController()
        vc.recipe = recipe
        vc.isEditing = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func recipeDidUpdate(_ notification: Notification) {
        guard let updatedRecipe = notification.object as? Recipe else { 
            return
        }
        if updatedRecipe == recipe {
            recipe = updatedRecipe
            navigationItem.title = recipe.name
            updateImagesCellContent()
            updateDetailsCellContent()
            tableView.updateLayout()
        }
    } 
    
    deinit {
        print("RecipeDetailViewController deinit")
    }
    
    private func makeSections() -> [StaticTableViewSection] {
        let section0 = StaticTableViewSection()
        section0.cells = [imagesCell]
        
        let section1 = StaticTableViewSection()
        section1.cells = [detailsCell]
        
        return [section0, section1]
    }
}
