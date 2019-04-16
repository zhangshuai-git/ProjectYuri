//
//  AddProductionViewController.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/04/11.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit

class AddProductionViewController: ZSViewController {
    
    let scrollerContentView = UIView()
    let scrollerView: UIScrollView = {
        let scrollerView = UIScrollView()
        scrollerView.isScrollEnabled = false
        return scrollerView
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    let originNameTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    let despTextView: UITextView = {
        let textView = UITextView()
        return textView
    }()
    
    let groupBtn: UISegmentedControl = {
        let groupBtn = UISegmentedControl(items: ["全部", "游戏", "动画", "漫画", "小说"])
        groupBtn.selectedSegmentIndex = 0
        groupBtn.tintColor = UIColor.main
        return groupBtn
    }()
    
    override func buildSubViews() {
        super.buildSubViews()
        view.addSubview(scrollerView)
        scrollerView.addSubview(scrollerContentView)
        scrollerContentView.addSubview(nameTextField)
        scrollerContentView.addSubview(originNameTextField)
        scrollerContentView.addSubview(despTextView)
        scrollerContentView.addSubview(groupBtn)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        scrollerView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(topLayoutGuide.snp.bottom)
            make.bottom.equalTo(bottomLayoutGuide.snp.top)
        }
        
        scrollerContentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        nameTextField.snp.makeConstraints { (make) in
            make.top.leading.right.equalTo(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
        
        originNameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(nameTextField.snp.bottom).offset(10)
            make.leading.right.equalTo(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
        
        despTextView.snp.makeConstraints { (make) in
            make.top.equalTo(originNameTextField.snp.bottom).offset(10)
            make.leading.right.equalTo(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
        
        groupBtn.snp.makeConstraints { (make) in
            make.top.equalTo(despTextView.snp.bottom).offset(10)
            make.bottom.leading.right.equalTo(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
    }
}
