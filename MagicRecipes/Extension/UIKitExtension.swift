//
//  UIKitExtension.swift
//  MagicRecipes
//
//  Created by 于涵 on 2019/12/29.
//  Copyright © 2019 yuhan. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    static func add(target: Any, action: Selector) -> UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .add, target: target, action: action)
    }
    
    static func edit(target: Any, action: Selector) -> UIBarButtonItem {
        return UIBarButtonItem(title: "编辑", style: .plain, target: target, action: action)
    }
    
    static func done(target: Any, action: Selector) -> UIBarButtonItem {
        return UIBarButtonItem(title: "完成", style: .done, target: target, action: action)
    }
    
    static func cancel(target: Any, action: Selector) -> UIBarButtonItem {
        return UIBarButtonItem(title: "取消", style: .plain, target: target, action: action)
    }
    
    static func back() -> UIBarButtonItem {
        return UIBarButtonItem(title: "返回", style: .plain, target: nil, action: nil)
    }
}

extension UIView {
    
    func edges(equalTo view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        let l = NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0)
        let r = NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0)
        let t = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        let b = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([l, r, t, b])
    }
    
    @discardableResult
    func addTapGestureRecognizer(target: Any, action: Selector) -> UITapGestureRecognizer {
        let gr = UITapGestureRecognizer(target: target, action: action)
        self.addGestureRecognizer(gr)
        self.isUserInteractionEnabled = true
        return gr
    }
    
    @discardableResult
    func addLongPressGestureRecognizer(target: Any, action: Selector) -> UILongPressGestureRecognizer {
        let gr = UILongPressGestureRecognizer(target: target, action: action)
        self.addGestureRecognizer(gr)
        self.isUserInteractionEnabled = true
        return gr
    }
}

extension UIAlertController {
    
    func addAction(title: String, style: UIAlertAction.Style, handler: ((UIAlertAction) -> Void)?) {
        let action = UIAlertAction(title: title, style: style, handler: handler)
        addAction(action)
    }
}

func +(lhs: UIEdgeInsets, rhs: UIEdgeInsets) -> UIEdgeInsets {
    let top = lhs.top + rhs.top
    let bottom = lhs.bottom + rhs.bottom
    let left = lhs.left + rhs.left
    let right = lhs.right + rhs.right
    return UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
}
