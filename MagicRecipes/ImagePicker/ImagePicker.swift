//
//  ImagePicker.swift
//  MagicRecipes
//
//  Created by 于涵 on 2020/3/6.
//  Copyright © 2020 yuhan. All rights reserved.
//

import UIKit

class ImagePicker: NSObject {
    
    private var currentOptions: ImagePickerOptions?
    
    static let shared = ImagePicker()
    
    func pickImage(options: ImagePickerOptions, inViewController vc: UIViewController) {
        currentOptions = options
        
        let ipc = UIImagePickerController()
        ipc.sourceType = .photoLibrary
        ipc.allowsEditing = options.allowsEditing
        ipc.delegate = self
        vc.present(ipc, animated: true, completion: options.presentCompletionHandler)
    }
}

extension ImagePicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageURL = info[.imageURL] as? URL {
            currentOptions?.successHandler?(imageURL)
        } else {
            currentOptions?.failureHandler?(ImageError.notFound)
        }
        currentOptions = nil // reset after picking
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
