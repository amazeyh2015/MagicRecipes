//
//  ImageManager.swift
//  MagicRecipes
//
//  Created by 于涵 on 2019/12/29.
//  Copyright © 2019 yuhan. All rights reserved.
//

import UIKit

enum ImageError: Error {
    
    case invalidURL
    case notFound
}

class ImageManager {
    
    static let shared = ImageManager()
    
    private let fileManager = FileManager.default
    private let directoryPath = NSHomeDirectory() + "/Documents/Images/"
    
    func createDirectoryIfNeeded() {
        if fileManager.fileExists(atPath: directoryPath) {
            return
        }
        do {
            try fileManager.createDirectory(atPath: directoryPath, withIntermediateDirectories: true)
        } catch {
            print(error)
        }
    }
    
    func savePathForImage(at url: URL) -> String {
        let name = url.lastPathComponent
        let path = directoryPath + name
        return path
    }
    
    func cacheKeyForImage(at url: URL) -> String {
        return url.absoluteString
    }
    
    func saveImage(from url: URL?, completionHandler:((URL?, Error?) -> Void)?) {
        // check url is valid
        guard let url = url else {
            completionHandler?(nil, ImageError.invalidURL)
            return
        }
        // check image exists
        let savePath = savePathForImage(at: url)
        let saveURL = URL(fileURLWithPath: savePath)
        if fileManager.fileExists(atPath: savePath) {
            completionHandler?(saveURL, nil)
            return
        }
        // move image
        do {
            try fileManager.moveItem(at: url, to: saveURL)
            completionHandler?(saveURL, nil)
        } catch {
            completionHandler?(nil, error)
        }
    }
    
    func loadImage(at url: URL?, completionHandler:((URL?, UIImage?, Error?) -> Void)?) {
        // check url is valid
        guard let url = url else {
            completionHandler?(nil, nil, ImageError.invalidURL)
            return
        }
        let key = cacheKeyForImage(at: url)
        if let image = ImageCache.shared.image(forKey: key) {
            completionHandler?(url, image, nil)
            return
        }
        let savePath = savePathForImage(at: url)
        if let image = UIImage(contentsOfFile: savePath) {
            ImageCache.shared.setImage(image, forKey: key)
            completionHandler?(url, image, nil)
        } else {
            completionHandler?(url, nil, ImageError.notFound)
        }
    }
}
