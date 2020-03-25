//
//  ImagePickerOptions.swift
//  MagicRecipes
//
//  Created by 于涵 on 2020/3/6.
//  Copyright © 2020 yuhan. All rights reserved.
//

import UIKit

enum ImagePickerMediaType {
    case image
    case movie
}

class ImagePickerOptions {
    
    var mediaTypes: [ImagePickerMediaType] = [.image]
    var allowsEditing: Bool = false
    var successHandler: ((URL) -> Void)?
    var failureHandler: ((Error) -> Void)?
}
