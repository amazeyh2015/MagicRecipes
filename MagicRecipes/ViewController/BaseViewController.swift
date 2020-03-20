//
//  BaseViewController.swift
//  MagicRecipes
//
//  Created by 于涵 on 2020/3/20.
//  Copyright © 2020 yuhan. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.backBarButtonItem = UIBarButtonItem.back()
    }
}
