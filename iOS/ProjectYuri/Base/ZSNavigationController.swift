//
//  ZSNavigationBar.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/03/25.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit

class ZSNavigationController: UINavigationController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// 自定义返回按钮后返回手势失效
        /// 手动实现返回手势代理
        interactivePopGestureRecognizer?.delegate = self
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        
        /// 如果当前控制器的子控制器个数大于等于1, 说明推出的控制器为子控制器
        if children.count > 0 {
            
            /// 自定义返回按钮
            let backBtn = UIButton()
            backBtn.setImage(UIImage(named: "IMG_Back"), for: .normal)
            backBtn.addTarget(self, action: #selector(goBack), for: .touchUpInside)
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
            
            /// 子控制器隐藏 bottomBar
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    /// 返回按钮点击事件
    @objc func goBack() {
        popViewController(animated: true)
    }
    
    /// 滑动返回手势
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        /// 判断是否需要滑动返回手势
        if gestureRecognizer == navigationController?.interactivePopGestureRecognizer {
            return navigationController!.children.count > 1
        }
        
        /// 解决当前控制器为根控制器的时候, 返回手势卡屏的问题
        if children.count == 1 {
            return false
        }
        
        return true
    }

}
