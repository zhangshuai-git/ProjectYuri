//
//  ProfileViewController.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/03/27.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit

class MeViewController: ZSViewController {

    let topView: MeTopView = {
        let view = MeTopView()
        return view
    }()
    
    let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    override func buildSubViews() {
        super.buildSubViews()
        rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_settings_black")?.toScale(0.7))
        view.addSubview(topView)
        view.addSubview(mainView)
        
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        topView.snp.makeConstraints { (make) in
            make.top.equalTo(topLayoutGuide.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(topView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height)
        }
        
        mainView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(bottomLayoutGuide.snp.top)
        }
        
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        let topViewTapedAction = UITapGestureRecognizer()
        view.addGestureRecognizer(topViewTapedAction)
        topViewTapedAction.rx.event
            .bind{ [weak self] _ in
                self?.gotoProfileViewController()
            }
            .disposed(by: disposeBag)
        
        rightBarButtonItem?.button?.rx.tap
            .bind{
                print("\($0) rightBarButtonItem")
            }
            .disposed(by: disposeBag)
        
    }
    
}

