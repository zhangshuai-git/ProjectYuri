//
//  ProfileViewController.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/04/03.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit
import SGPagingView

class ProfileViewController: ZSViewController {
    
    var pageTitleView: SGPageTitleView?
    var pageContentScrollView: SGPageContentScrollView?

    override func buildSubViews() {
        super.buildSubViews()
        let statusHeight: CGFloat = UIApplication.shared.statusBarFrame.height
        var pageTitleViewY: CGFloat = 0
        if statusHeight == 20.0 {
            pageTitleViewY = 64
        } else {
            pageTitleViewY = 88
        }
        
        let configure = SGPageTitleViewConfigure()
        pageTitleView = SGPageTitleView(frame: CGRect(x: 0, y: 0, width: UIScreen.width, height: 40), delegate: self, titleNames: ["游戏", "动画", "漫画", "小说"], configure: configure)
        view.addSubview(pageTitleView!)
        
        var vcArray: [AnyHashable] = []
        for _ in 0..<5 {
            let vc = HomeViewController()
            vc.view.backgroundColor = UIColor.random
            vcArray.append(vc)
        }
        
        let contentViewHeight: CGFloat = view.frame.size.height - pageTitleView!.frame.maxY - pageTitleViewY
        pageContentScrollView = SGPageContentScrollView(frame: CGRect(x: 0, y: pageTitleView!.frame.maxY, width: view.frame.size.width, height: contentViewHeight), parentVC: self, childVCs: vcArray)
        pageContentScrollView!.delegatePageContentScrollView = self
        view.addSubview(pageContentScrollView!)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
    }
}

extension ProfileViewController: SGPageTitleViewDelegate, SGPageContentScrollViewDelegate {
    func pageTitleView(_ pageTitleView: SGPageTitleView?, selectedIndex: Int) {
        NSLog("%ld", selectedIndex)
        pageContentScrollView?.setPageContentScrollViewCurrentIndex(selectedIndex)
    }
    
    func pageContentScrollView(_ pageContentScrollView: SGPageContentScrollView?, progress: CGFloat, originalIndex: Int, targetIndex: Int) {
        NSLog("%ld - %ld", originalIndex, targetIndex)
        pageTitleView?.setPageTitleViewWithProgress(progress, originalIndex: originalIndex, targetIndex: targetIndex)
    }
}
