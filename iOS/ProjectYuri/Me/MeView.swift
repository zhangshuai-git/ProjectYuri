//
//  ProfileView.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/04/02.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit

class MeTopView: ZSView {

    let userView: ZSUserView = {
        let view = ZSUserView(iconSize: CGSize(width: 60, height: 60), titleFont: UIFont.systemFont(ofSize: 16), contentFont: UIFont.systemFont(ofSize: 10))
        view.iconImg.layer.cornerRadius = 30
        view.iconImg.layer.masksToBounds = true
        view.iconImg.backgroundColor = UIColor.random
        view.titleLab.text = String.random(len: 8)
        view.contentLab.text = "UID: \(String.random(len: 8))"
        return view
    }()
    
    let arrowImg: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "ipad_player_setup_arrow")
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override func buildSubViews() {
        super.buildSubViews()
        backgroundColor = UIColor.main
        addSubview(userView)
        addSubview(arrowImg)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        userView.snp.makeConstraints { (make) in
            make.leading.equalTo(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
            make.top.greaterThanOrEqualToSuperview().offset(-10)
            make.bottom.lessThanOrEqualToSuperview().offset(-10)
        }
        
        arrowImg.snp.makeConstraints { (make) in
            make.trailing.equalTo(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 20))
            make.top.greaterThanOrEqualToSuperview().offset(0)
            make.bottom.lessThanOrEqualToSuperview().offset(-20)
            make.centerY.equalTo(userView)
            make.size.equalTo(CGSize(width: 15, height: 15))
            make.leading.equalTo(userView.snp.trailing).offset(10)
        }
    }

}
