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
    
    /// 通过自定义方法添加所有子控制器
    func createChildController() {
        addChildVC(childVc: HomeViewController(), title: "首页".localized, image: "IMG_Home", selectedImage: "IMG_Home_Selected")
        addChildVC(childVc: UIViewController(), title: "我的".localized, image: "IMG_More", selectedImage: "IMG_More_Selected")
    }
    
    /// 自定义添加子控制器
    func addChildVC(childVc: UIViewController, title:String, image: String, selectedImage: String) {
        let nav = ZSNavigationController(rootViewController: childVc)
        let normalImage = UIImage(named: image)
        let selectedImage = UIImage(named: selectedImage)
        nav.navigationItem.title = title
        nav.tabBarItem = tabbarItem(with: title, normalImage: normalImage!, selectedImage: selectedImage!)
        addChild(nav)
    }
    
    /// 快捷创建 UITabBarItem
    func tabbarItem(with title: String, normalImage: UIImage, selectedImage: UIImage) -> UITabBarItem{
        let image = normalImage.withRenderingMode(.alwaysOriginal)
        let _selectedImage = selectedImage.withRenderingMode(.alwaysOriginal)
        let tabBarItem = UITabBarItem(title: title, image: image, selectedImage: _selectedImage)
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(hex: MAIN_COLOR)], for: .selected)
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(hex: TABBAR_NORMAL_COLOR)], for: .normal)
        return tabBarItem
    }

}
