//
//  ProfileViewController.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/04/03.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProfileViewController: ZSViewController {
    
    class var itemCount: Int {
        get{ return 4 }
    }
    
    class var itemWidth: CGFloat {
        get{ return (UIScreen.width - (CGFloat(itemCount) + 1) * 10.0) / CGFloat(itemCount) }
    }

    let collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: itemWidth, height: itemWidth + 20)
        layout.headerReferenceSize = CGSize(width: UIScreen.width, height: 30)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.groupTableViewBackground
        collectionView.zs.register(ProfileCell.self)
        return collectionView
    }()
    
    override func buildSubViews() {
        super.buildSubViews()
        view.addSubview(collectionView)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(topLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(bottomLayoutGuide.snp.top)
        }
    }
    
    let dataSource = BehaviorRelay(value: [Production]())
    
    override func bindViewModel() {
        super.bindViewModel()
        
        dataSource
            .bind(to: collectionView.rx.items) { collectionView, row, element in
                let cell = collectionView.zs.dequeueReusableCell(ProfileCell.self, for: IndexPath(row: row, section: 0))
                return cell
            }
            .disposed(by: disposeBag)
        
    }
    
}
