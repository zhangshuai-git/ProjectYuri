//
//  CategoryViewController.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/03/27.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit

class CategoryViewController: ZSViewController {

    lazy var actionBtn: UIButton = {
        let button = UIButton()
        button.setTitle("搜索", for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 22
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    override func buildSubViews() {
    }
    
    override func makeConstraints() {
    }

}
