//
//  ZSCharacterView.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/04/01.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit

class ZSUserView: ZSView {

    let iconImg: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let titleLab: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .white
        return label
    }()
    
    let contentLab: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .white
        return label
    }()
    
    override func buildSubViews() {
        super.buildSubViews()
        addSubview(iconImg)
        addSubview(titleLab)
        addSubview(contentLab)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        iconImg.snp.makeConstraints { (make) in
            make.top.left.equalTo(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.bottom.lessThanOrEqualToSuperview().offset(-10)
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.top.right.equalTo(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
            make.left.equalTo(iconImg.snp.right).offset(10)
        }
        
        contentLab.snp.makeConstraints { (make) in
            make.right.equalTo(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
            make.left.equalTo(iconImg.snp.right).offset(10)
            make.top.equalTo(titleLab.snp.bottom).offset(10)
            make.bottom.lessThanOrEqualToSuperview().offset(-10)
        }
    }

}
