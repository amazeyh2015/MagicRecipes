//
//  RecipeEditViewController.swift
//  MagicRecipes
//
//  Created by 于涵 on 2019/11/2.
//  Copyright © 2019 yuhan. All rights reserved.
//

import UIKit
import StaticTableView
import EasyKeyboard

class RecipeEditViewController: BaseViewController {
    
    private var nameHeaderView: RecipeHeaderView!
    private var imagesHeaderView: RecipeHeaderView!
    private var detailsHeaderView: RecipeHeaderView!
    private var nameCell: RecipeNameCell!
    private var imageCell: RecipeImageCell!
    private var addImageCell: RecipeAddImageCell!
    private var detailsCell: RecipeDetailsCell!
    private var tableView: StaticTableView!
    
    var recipe = Recipe()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = isEditing ? "编辑菜谱" : "创建菜谱"
        navigationItem.rightBarButtonItem = UIBarButtonItem.done(target: self, action: #selector(doneButtonClicked))
        
        nameHeaderView = RecipeHeaderView()
        nameHeaderView.title = "名字(必填)"
        
        imagesHeaderView = RecipeHeaderView()
        imagesHeaderView.title = "图片(必填)"
        
        detailsHeaderView = RecipeHeaderView()
        detailsHeaderView.title = "做法(选填)"
        
        nameCell = RecipeNameCell()
        nameCell.name = recipe.name
        nameCell.delegate = self
        
        imageCell = RecipeImageCell()
        ImageManager.shared.loadImage(at: recipe.imageURLs.first) { (_, image, _) in
            self.imageCell.image = image
        }
        imageCell.didSelectAction = { [unowned self] in
            self.view.endEditing(true)
            self.imageCellSelected() 
        }
        
        addImageCell = RecipeAddImageCell()
        addImageCell.didSelectAction = { [unowned self] in
            self.view.endEditing(true)
            self.addImageCellSelected()
        }
        
        detailsCell = RecipeDetailsCell()
        detailsCell.details = recipe.details
        detailsCell.delegate = self
        
        tableView = StaticTableView()
        tableView.backgroundColor = .systemGroupedBackground
        tableView.sections = makeSections()
        view = tableView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        KeyboardManager.shared.addObserver(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        KeyboardManager.shared.removeObserver(self)
    }
    
    deinit {
        print("RecipeEditViewController deinit")
    }
    
    private func makeSections() -> [StaticTableViewSection] {
        let section0 = StaticTableViewSection()
        section0.header = nameHeaderView
        section0.cells = [nameCell]
        
        let section1 = StaticTableViewSection()
        section1.header = imagesHeaderView
        if imageCell.image == nil {
            section1.cells = [addImageCell]
        } else {
            section1.cells = [imageCell]
        }
        
        let section2 = StaticTableViewSection()
        section2.header = detailsHeaderView
        section2.cells = [detailsCell]
        
        return [section0, section1, section2]
    }
    
    @objc private func doneButtonClicked() {
        // check content
        if recipe.name.isEmpty {
            let ac = UIAlertController(title: nil, message: "名字不能为空", preferredStyle: .alert)
            ac.addAction(title: "好的", style: .cancel, handler: nil)
            present(ac, animated: true, completion: nil)
            return
        }
        if recipe.imageURLs.isEmpty {
            let ac = UIAlertController(title: nil, message: "图片不能为空", preferredStyle: .alert)
            ac.addAction(title: "好的", style: .cancel, handler: nil)
            present(ac, animated: true, completion: nil)
            return
        }
        // update or add recipe
        if isEditing {
            RecipeStore.updateRecipe(recipe)
        } else {
            RecipeStore.addRecipe(recipe)
        }
        // dismiss view controller
        navigationController?.popViewController(animated: true)
    }
    
    private func addImageCellSelected() {
        let options = ImagePickerOptions()
        options.allowsEditing = true
        options.successHandler = { [weak self] imageURL in
            self?.didSelectImage(imageURL)
        }
        ImagePicker.shared.pickImage(options: options, inViewController: self)
    }
    
    private func imageCellSelected() {
        guard let image = imageCell.image else {
            return
        }
        
        let ac = UIAlertController(title: "是否删除此图片", message: nil, preferredStyle: .alert)
        ac.addAction(title: "取消", style: .cancel, handler: nil)
        ac.addAction(title: "删除", style: .destructive) { _ in
            self.deleteImage(image)
        }
        present(ac, animated: true, completion: nil)
    }
    
    private func didSelectImage(_ imageURL: URL) {
        ImageManager.shared.saveImage(from: imageURL) { (imageURL, error) in
            ImageManager.shared.loadImage(at: imageURL, completionHandler: { (imageURL, image, error) in
                if let imageURL = imageURL, let image = image {
                    self.recipe.imageURLs = [imageURL]
                    self.imageCell.image = image
                    self.tableView.sections = self.makeSections()
                    self.tableView.updateLayout()
                }
            })
        }
    }
    
    private func deleteImage(_ image: UIImage) {
        recipe.imageURLs = []
        imageCell.image = nil
        tableView.sections = makeSections()
        tableView.updateLayout()
    }
}

extension RecipeEditViewController: KeyboardObservering {
    
    func keyboardWillShow(keyboardInfo: KeyboardInfo) {
        tableView.contentInset.bottom = keyboardInfo.endFrame.height
    }
    
    func keyboardDidShow(keyboardInfo: KeyboardInfo) {
        if detailsCell.isEditing {
            let rect = detailsCell.convert(detailsCell.detailsRect, to: tableView)
            tableView.scrollRectToVisible(rect, animated: true)
        }
    }
    
    func keyboardWillHide(keyboardInfo: KeyboardInfo) {
        tableView.contentInset.bottom = 0
    }
}

extension RecipeEditViewController: RecipeNameCellDelegate {
    
    func recipeNameCell(_ cell: RecipeNameCell, nameDidChange name: String?) {
        recipe.name = name ?? ""
    }
}

extension RecipeEditViewController: RecipeDetailsCellDelegate {
    
    func recipeDetailsCell(_ cell: RecipeDetailsCell, detailsDidChange details: String) {
        recipe.details = details
    }
    
    func recipeDetailsCell(_ cell: RecipeDetailsCell, detailsHeightDidChange height: CGFloat) {
        tableView.updateLayoutForElement(cell)
        let rect = detailsCell.convert(cell.detailsRect, to: tableView)
        tableView.scrollRectToVisible(rect, animated: true)
    }
}
