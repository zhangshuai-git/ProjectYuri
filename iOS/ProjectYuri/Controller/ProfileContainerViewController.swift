//
//  ProfileViewController.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/04/03.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit
import SGPagingView

class ProfileContainerViewController: ZSViewController {
    
    var pageTitleView: SGPageTitleView?
    var pageContentScrollView: SGPageContentCollectionView?

    override func buildSubViews() {
        super.buildSubViews()
        
        let configure = SGPageTitleViewConfigure()
        pageTitleView = SGPageTitleView(frame: CGRect.zero, delegate: self, titleNames: ["游戏", "动画", "漫画", "小说"], configure: configure)
        view.addSubview(pageTitleView!)
        
        var vcArray: [AnyHashable] = []
        for _ in 0..<5 {
            let vc = ProfileViewController()
            vc.view.backgroundColor = UIColor.random
            vcArray.append(vc)
        }
        pageContentScrollView = SGPageContentCollectionView(frame: CGRect.zero, parentVC: self, childVCs: vcArray)
        pageContentScrollView?.delegatePageContentCollectionView = self
        view.addSubview(pageContentScrollView!)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        if let pageTitleView = pageTitleView, let pageContentScrollView = pageContentScrollView {
            pageTitleView.snp.makeConstraints({ (make) in
                make.top.equalTo(topLayoutGuide.snp.bottom)
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(40)
            })
            
            pageContentScrollView.snp.makeConstraints({ (make) in
                make.top.equalTo(pageTitleView.snp.bottom)
                make.bottom.equalTo(bottomLayoutGuide.snp.top)
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(40)
            })
        }
    }
}

extension ProfileContainerViewController: SGPageTitleViewDelegate, SGPageContentCollectionViewDelegate {
    func pageTitleView(_ pageTitleView: SGPageTitleView, selectedIndex: Int) {
        NSLog("%ld", selectedIndex)
        pageContentScrollView?.setPageContentCollectionViewCurrentIndex(selectedIndex)
    }
    
    func pageContentCollectionView(_ pageContentCollectionView: SGPageContentCollectionView, progress: CGFloat, originalIndex: Int, targetIndex: Int) {
        NSLog("%ld - %ld", originalIndex, targetIndex)
        pageTitleView?.setPageTitleViewWithProgress(progress, originalIndex: originalIndex, targetIndex: targetIndex)
    }
}
