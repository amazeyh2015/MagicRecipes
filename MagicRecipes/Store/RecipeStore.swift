//
//  RecipeStore.swift
//  MagicRecipes
//
//  Created by 于涵 on 2019/11/3.
//  Copyright © 2019 yuhan. All rights reserved.
//

import Foundation

extension Notification.Name {
    
    static let RecipeDidUpdate = Notification.Name("RecipeDidUpdate")
    static let RecipesDidUpdate = Notification.Name("RecipesDidUpdate")
}

struct RecipeStore {
    
    private(set) static var recipes: [Recipe] = []
    
    static func loadRecipes() {
        recipes = loadRecipesFromDisk()
        NotificationCenter.default.post(name: .RecipesDidUpdate, object: nil)
    }
    
    static func addRecipe(_ recipe: Recipe) {
        recipes.append(recipe)
        NotificationCenter.default.post(name: .RecipesDidUpdate, object: nil)
        saveRecipesToDisk()
    }
    
    static func deleteRecipe(_ recipe: Recipe) {
        if let index = recipes.firstIndex(of: recipe) {
            recipes.remove(at: index)
            NotificationCenter.default.post(name: .RecipesDidUpdate, object: nil)
            saveRecipesToDisk()
        }
    }
    
    static func updateRecipe(_ recipe: Recipe) {
        if let index = recipes.firstIndex(of: recipe) {
            recipes[index] = recipe
            NotificationCenter.default.post(name: .RecipeDidUpdate, object: recipe)
            NotificationCenter.default.post(name: .RecipesDidUpdate, object: nil)
            saveRecipesToDisk()
        }
    }
    
    private static let recipesURL = getRecipesURL()
    private static let encoder = JSONEncoder()
    private static let decoder = JSONDecoder()
    
    private static func getRecipesURL() -> URL {
        let path = NSHomeDirectory() + "/Documents/recipes.json"
        return URL(fileURLWithPath: path)
    }
    
    private static func loadRecipesFromDisk() -> [Recipe] {
        guard let data = try? Data(contentsOf: recipesURL) else {
            return []
        }
        if let recipes = try? decoder.decode([Recipe].self, from: data) {
            return recipes
        }
        return []
    }
    
    private static func saveRecipesToDisk() {
        if let data = try? encoder.encode(recipes) {
            do {
                try data.write(to: recipesURL)
            } catch {
                print(error)
            }
        }
    }
}
