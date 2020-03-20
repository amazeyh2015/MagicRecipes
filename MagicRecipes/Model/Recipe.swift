//
//  Recipe.swift
//  MagicRecipes
//
//  Created by 于涵 on 2019/11/2.
//  Copyright © 2019 yuhan. All rights reserved.
//

import UIKit

struct Recipe: Codable {
    let recipeID: String = NSUUID().uuidString
    var name: String = ""
    var imageURLs: [URL] = []
    var details: String = ""
}

extension Recipe: Equatable {
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.recipeID == rhs.recipeID
    }
}
