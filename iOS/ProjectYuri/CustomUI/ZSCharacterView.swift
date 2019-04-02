//
//  ZSCharacterView.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/04/01.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit

class ZSCharacterView: ZSView {

    let iconImg: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let charaLab: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .white
        return label
    }()
    
    let cvLab: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .white
        return label
    }()
    
    override func buildSubViews() {
        super.buildSubViews()
        addSubview(iconImg)
        addSubview(charaLab)
        addSubview(cvLab)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        iconImg.snp.makeConstraints { (make) in
            make.top.left.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.bottom.lessThanOrEqualToSuperview().offset(-10)
        }
        
        charaLab.snp.makeConstraints { (make) in
            make.top.right.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
            make.left.equalTo(iconImg.snp.right).offset(10)
        }
        
        cvLab.snp.makeConstraints { (make) in
            make.right.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
            make.left.equalTo(iconImg.snp.right).offset(10)
            make.top.equalTo(charaLab.snp.bottom).offset(10)
            make.bottom.lessThanOrEqualToSuperview().offset(-10)
        }
    }

}
