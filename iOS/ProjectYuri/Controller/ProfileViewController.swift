//
//  ProfileViewController.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/03/27.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit

class ProfileViewController: ZSViewController {

    let topView: ProfileTopView = {
        let view = ProfileTopView()
        return view
    }()

    override func buildSubViews() {
        super.buildSubViews()
        view.addSubview(topView)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        topView.snp.makeConstraints { (make) in
            make.top.equalTo(topLayoutGuide.snp.bottom)
            make.left.right.equalToSuperview()
        }
    }
}
