//
//  CategoryViewController.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/03/27.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit

class CategoryViewController: ZSViewController {

    lazy var navigationTitleBtn: UIButton = {
        let button = UIButton()
        button.setTitle("搜索", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 14
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    override func buildSubViews() {
        navigationTitleBtn.frame = CGRect(x: 0, y: 0, width: SCREEN_MIN_LENGTH - 40, height: 0);
        navigationItem.titleView = navigationTitleBtn
    }
    
    override func makeConstraints() {
        
    }
    
    override func bindViewModel() {
        navigationTitleBtn.rx.tap
            .asObservable()
            .bind { [weak self] in
                self?.gotoSearchViewController()
            }
            .disposed(by: disposeBag)
    }

}
