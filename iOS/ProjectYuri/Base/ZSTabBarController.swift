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
        addChildVC(HomeViewController.self, title: "首页", image: "index_tabbar_index", selectedImage: "index_tabbar_index_1")
        addChildVC(SearchViewController.self, title: "搜索", image: "index_tabbar_backlog", selectedImage: "index_tabbar_backlog_1")
        addChildVC(ProfileViewController.self, title: "我的", image: "index_tabbar_mine", selectedImage: "index_tabbar_mine_1")
    }
    
    func addChildVC(_ childVcType: UIViewController.Type, title:String, image: String, selectedImage: String) {
        let vc = childVcType.init()
        vc.title = title
        let image = UIImage(named: image)
        let selectedImage = UIImage(named: selectedImage)
        let nav = ZSNavigationController(rootViewController: vc)
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
