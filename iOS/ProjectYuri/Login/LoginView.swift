//
//  LoginView.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/05/23.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class LoginHeaderView: ZSView {
    
    let mainView = UIView()
    
    override func buildSubViews() {
        super.buildSubViews()
        addSubview(mainView)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        mainView.snp.makeConstraints { (make) in
            make.top.bottom.leading.trailing.equalTo(UIEdgeInsets(top: 30, left: 40, bottom: 40, right: 40))
            make.size.equalTo(CGSize(width: 100, height: 60))
        }
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
    }
}

class LoginFooterView: ZSView {
    let signup: UIButton = {
        let button = UIButton()
        button.setTitle("注册", for: .normal)
        button.backgroundColor = UIColor.main
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return button
    }()
    
    let signin: UIButton = {
        let button = UIButton()
        button.setTitle("登陆", for: .normal)
        button.backgroundColor = UIColor.main
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return button
    }()
    
    override func buildSubViews() {
        super.buildSubViews()
        addSubview(signup)
        addSubview(signin)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        signup.snp.makeConstraints { (make) in
            make.top.bottom.leading.equalTo(UIEdgeInsets(top: 30, left: 40, bottom: 40, right: 40))
            make.height.equalTo(40)
        }
        
        signin.snp.makeConstraints { (make) in
            make.leading.equalTo(signup.snp.trailing).offset(20)
            make.top.bottom.trailing.equalTo(UIEdgeInsets(top: 30, left: 40, bottom: 40, right: 40))
            make.height.equalTo(40)
            make.width.equalTo(signup)
        }
    }
    
    let input = PublishRelay<LoginModel>()
    let output = PublishRelay<LoginModel>()
    
    override func bindViewModel() {
        signup.rx.tap
            .map{LoginModel(signupAction: ())}
            .bind(to: output)
            .disposed(by: disposeBag)
        
        signin.rx.tap
            .map{LoginModel(signinAction: ())}
            .bind(to: output)
            .disposed(by: disposeBag)
    }
}
