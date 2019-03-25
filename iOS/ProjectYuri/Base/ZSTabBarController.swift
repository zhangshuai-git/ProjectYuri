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
        addChildVC(childVc: HomeViewController.self, title: "首页".localized, image: "IMG_Home", selectedImage: "IMG_Home_Selected")
        addChildVC(childVc: UIViewController.self, title: "我的".localized, image: "IMG_More", selectedImage: "IMG_More_Selected")
    }
    
    func addChildVC(childVc: UIViewController.Type, title:String, image: String, selectedImage: String) {
        let nav = ZSNavigationController(rootViewController: childVc.init())
        let normalImage = UIImage(named: image)
        let selectedImage = UIImage(named: selectedImage)
        nav.navigationItem.title = title
        nav.tabBarItem = tabbarItem(with: title, normalImage: normalImage, selectedImage: selectedImage)
        addChild(nav)
    }
    
    func tabbarItem(with title: String, normalImage: UIImage? = nil, selectedImage: UIImage? = nil) -> UITabBarItem{
        let normalImage = normalImage?.withRenderingMode(.alwaysOriginal)
        let selectedImage = selectedImage?.withRenderingMode(.alwaysOriginal)
        let tabBarItem = UITabBarItem(title: title, image: normalImage, selectedImage: selectedImage)
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(hex: MAIN_COLOR)], for: .selected)
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(hex: TABBAR_NORMAL_COLOR)], for: .normal)
        return tabBarItem
    }

}
