//
//  ZSNavigationBar.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/03/25.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit

class ZSNavigationController: UINavigationController {
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        registGestureDelegate()
//    }
    
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            if children.count > 0 {
                viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(target: self, action: #selector(goBack), image: UIImage(named: "back-navi-white"))
                /// 子控制器隐藏TabBar
                viewController.hidesBottomBarWhenPushed = true
            }
            super.pushViewController(viewController, animated: animated)
        }
    
        @objc func goBack() {
            popViewController(animated: true)
        }
}

//extension ZSNavigationController: UIGestureRecognizerDelegate {
//    func registGestureDelegate() {
//        /// 自定义返回按钮后返回手势失效
//        /// 手动实现返回手势代理
//        interactivePopGestureRecognizer?.delegate = self
//    }
//
//    /// 滑动返回手势
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
//        /// 判断是否需要滑动返回手势
//        if gestureRecognizer == navigationController?.interactivePopGestureRecognizer {
//            return navigationController!.children.count > 1
//        }
//        /// 解决当前控制器为根控制器的时候, 返回手势卡屏的问题
//        if children.count == 1 {
//            return false
//        }
//        return true
//    }
//}
