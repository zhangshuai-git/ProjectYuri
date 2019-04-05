//
//  UITabBarController.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/04/03.
//  Copyright © 2019 張帥. All rights reserved.
//

import ZSUtils

extension UITabBarController {
    func addChildVC(_ childVcType: UIViewController.Type, title:String, image: String, selectedImage: String) {
        let image = UIImage(named: image)
        let selectedImage = UIImage(named: selectedImage)
        let nav = ZSNavigationController(rootViewController: childVcType.init())
        nav.navigationItem.title = title
        nav.tabBarItem = tabbarItem(with: title, image: image, selectedImage: selectedImage)
        addChild(nav)
    }
    
    func tabbarItem(with title: String, image: UIImage? = nil, selectedImage: UIImage? = nil) -> UITabBarItem{
        let image = image?.withRenderingMode(.alwaysOriginal)
        let selectedImage = selectedImage?.withRenderingMode(.alwaysOriginal)
        let tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.main], for: .selected)
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.lightGray], for: .normal)
        return tabBarItem
    }
}
