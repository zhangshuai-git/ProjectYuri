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
        rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_settings_black")?.toScale(0.7))
        view.addSubview(topView)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        topView.snp.makeConstraints { (make) in
            make.top.equalTo(topLayoutGuide.snp.bottom)
            make.left.right.equalToSuperview()
        }
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        rightBarButtonItem?.button?.rx.tap
            .bind{
                print($0)
            }
            .disposed(by: disposeBag)
    }
}
