//
//  ZSTabBarController.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/03/25.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit

class ZSTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createChildController()
    }
    
    func createChildController() {
        addChildVC(HomeViewController.self, title: "首页", image: "home-tab", selectedImage: "home-tab-selected")
        addChildVC(UIViewController.self, title: "我的", image: "menu-tab", selectedImage: "menu-tab-selected")
    }
    
    func addChildVC(_ childVcType: UIViewController.Type, title:String, image: String, selectedImage: String) {
        let nav = ZSNavigationController(rootViewController: childVcType.init())
        let image = UIImage(named: image)
        let selectedImage = UIImage(named: selectedImage)
        nav.navigationItem.title = title
        nav.tabBarItem = tabbarItem(with: title, image: image, selectedImage: selectedImage)
        addChild(nav)
    }
    
    func tabbarItem(with title: String, image: UIImage? = nil, selectedImage: UIImage? = nil) -> UITabBarItem{
        let image = image?.withRenderingMode(.alwaysOriginal)
        let selectedImage = selectedImage?.withRenderingMode(.alwaysOriginal)
        let tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(hex: MAIN_COLOR)], for: .selected)
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.lightGray], for: .normal)
        return tabBarItem
    }

}
