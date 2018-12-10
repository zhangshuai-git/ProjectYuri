//
//  HomeTableViewCell.swift
//  RxSwiftDemo
//
//  Created by 張帥 on 2018/12/10.
//  Copyright © 2018 張帥. All rights reserved.
//

class HomeTableViewCell: BaseTableViewCell {
    
    lazy var titleLab: UILabel = {
        let titleLab = UILabel()
        titleLab.adjustsFontSizeToFitWidth = true
        return titleLab
    }()
    
    lazy var actionBtn: UIButton = {
        let actionBtn = UIButton()
        actionBtn.setTitle("Button", for: .normal)
        actionBtn.setTitleColor(UIColor.black, for: .normal)
        actionBtn.layer.cornerRadius = 5
        actionBtn.layer.masksToBounds = true
        actionBtn.layer.borderColor = UIColor.green.cgColor
        actionBtn.layer.borderWidth = 1
        actionBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return actionBtn
    }()
    
    lazy var inputText: UITextField = {
        let inputText = UITextField()
        inputText.placeholder = "please input number"
        inputText.backgroundColor = UIColor.white
        inputText.clearButtonMode = .whileEditing
        inputText.keyboardType = .numberPad
        inputText.textAlignment = .left
        return inputText
    }()
    
    override func buildSubViews() {
        contentView.addSubview(titleLab)
        contentView.addSubview(inputText)
        contentView.addSubview(actionBtn)
    }
    
    override func makeConstraints() {
        titleLab.snp.makeConstraints { (make) in
            make.top.left.equalTo(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
            make.right.lessThanOrEqualTo(actionBtn.snp.left).offset(10)
        }
        
        inputText.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom).offset(20)
            make.bottom.left.equalTo(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
            make.right.lessThanOrEqualTo(actionBtn.snp.left).offset(10)
        }
        
        actionBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.top.bottom.right.equalTo(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
            make.size.equalTo(CGSize(width: 80, height: 80))
        }
    }
    
}

