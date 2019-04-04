//
//  ProfileViewController.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/04/03.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit
import SGPagingView
import RxCocoa
import RxSwift

class ProfileContainerViewController: ZSViewController {
    
    let mockData: [Repository] = {
        var array = [Repository]()
        for _ in 0..<40 {
            array.append(Repository())
        }
        return array
    }()
    
    let titles = ["游戏", "动画", "漫画", "小说"]
    
    lazy var vcArray: [AnyHashable] = {
        var vcArray = [AnyHashable]()
        for _ in 0..<titles.count {
            let vc = ProfileViewController()
            Observable.of(mockData).bind(to: vc.dataSource).disposed(by: disposeBag)
            vcArray.append(vc)
        }
        return vcArray
    }()
    
    lazy var pageTitleView: SGPageTitleView = {
        let configure = SGPageTitleViewConfigure()
        configure.indicatorColor = UIColor.main
        configure.titleSelectedColor = UIColor.main
        let pageTitleView: SGPageTitleView = SGPageTitleView(frame: CGRect.zero, delegate: self, titleNames:titles, configure: configure)
        return pageTitleView
    }()
    
    lazy var pageContentScrollView: SGPageContentCollectionView = {
        let pageContentScrollView: SGPageContentCollectionView = SGPageContentCollectionView(frame: CGRect.zero, parentVC: self, childVCs: vcArray)
        pageContentScrollView.delegatePageContentCollectionView = self
        return pageContentScrollView
    }()

    override func buildSubViews() {
        super.buildSubViews()
        view.addSubview(pageTitleView)
        view.addSubview(pageContentScrollView)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
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

extension ProfileContainerViewController: SGPageTitleViewDelegate, SGPageContentCollectionViewDelegate {
    func pageTitleView(_ pageTitleView: SGPageTitleView, selectedIndex: Int) {
        NSLog("%ld", selectedIndex)
        pageContentScrollView.setPageContentCollectionViewCurrentIndex(selectedIndex)
    }
    
    func pageContentCollectionView(_ pageContentCollectionView: SGPageContentCollectionView, progress: CGFloat, originalIndex: Int, targetIndex: Int) {
        NSLog("%ld - %ld", originalIndex, targetIndex)
        pageTitleView.setPageTitleViewWithProgress(progress, originalIndex: originalIndex, targetIndex: targetIndex)
    }
}
