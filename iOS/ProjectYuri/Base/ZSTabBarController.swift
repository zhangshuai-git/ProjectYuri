//
//  ZSTabBarController.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/04/03.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit

class ZSTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createChildController()
    }
    
    func createChildController() {
        addChildVC(HomeViewController.self, title: "首页", image: "index_tabbar_index", selectedImage: "index_tabbar_index_1")
        addChildVC(MeViewController.self, title: "我的", image: "index_tabbar_mine", selectedImage: "index_tabbar_mine_1")
    }
}
