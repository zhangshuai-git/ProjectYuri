//
//  RepositoryViewController.swift
//  RxSwiftDemo
//
//  Created by 張帥 on 2018/12/13.
//  Copyright © 2018 張帥. All rights reserved.
//

import UIKit

class OwnerViewController: BaseViewController {
    
    lazy var iconImg: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var titleLab: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var detailLab: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    var owner: RepositoryOwner?
    
    override func buildSubViews() {
        view.addSubview(iconImg)
        view.addSubview(titleLab)
        view.addSubview(detailLab)
    }

    override func makeConstraints() {
        iconImg.snp.makeConstraints { (make) in
            make.top.left.equalTo(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
            make.size.equalTo(CGSize(width: 60, height: 60))
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
            make.left.equalTo(iconImg.snp.right).offset(10)
            make.centerY.equalTo(iconImg)
        }
        
        detailLab.snp.makeConstraints { (make) in
            make.top.equalTo(iconImg.snp.bottom).offset(20)
            make.bottom.left.right.equalTo(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        }
    }
    
    override func bindViewModel() {
        guard let owner = owner else { return }
        
        titleLab.text = owner.login
        detailLab.text = owner.url
    }
}
