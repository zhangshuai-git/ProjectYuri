//
//  PurchaseCell.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/04/03.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit

class ProfileCell: ZSCollectionViewCell {
    
    let iconImg: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = UIColor.random
        return imageView
    }()
    
    let nameLab: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.text = String.random(len: 12)
        return label
    }()
    
    override func buildSubViews() {
        super.buildSubViews()
        backgroundColor = UIColor.main
        contentView.addSubview(iconImg)
        contentView.addSubview(nameLab)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        iconImg.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(UIEdgeInsets.zero)
            make.height.equalTo(iconImg.snp.width).multipliedBy(1.0)
            make.width.equalTo(ProfileViewController.itemWidth)
        }
        
        nameLab.snp.makeConstraints { (make) in
            make.bottom.leading.trailing.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0))
            make.height.equalTo(15)
            make.top.equalTo(iconImg.snp.bottom)
        }
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
    }
}
