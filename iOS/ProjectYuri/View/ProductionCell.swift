//
//  ProductionCell.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/05/13.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ProductionCell0: ZSTableViewCell {

    let titleLab: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.groupTableViewBackground
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = true
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.clearButtonMode = .whileEditing
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.leftViewMode = .always
        return textField
    }()

    override func buildSubViews() {
        super.buildSubViews()
        contentView.addSubview(titleLab)
        contentView.addSubview(textField)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        titleLab.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(UIEdgeInsets(top: 30, left: 20, bottom: 10, right: 20))
        }
        
        textField.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom).offset(10)
            make.bottom.leading.trailing.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
            make.height.equalTo(30)
        }
        
    }
    
    let input = PublishRelay<ProductionModel>()
    let output = PublishRelay<ProductionModel>()
    
    override func bindViewModel() {
        super.bindViewModel()
        
        input
            .bind{ [weak self] in guard let `self` = self else { return }
                self.titleLab.text = $0.title
                self.textField.text = $0.content
                self.textField.placeholder = $0.detail
            }
            .disposed(by: disposeBag)
        
        textField.rx.text.orEmpty
            .skip(1)
            .debounce(1.0, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .map{ ProductionModel(content: $0) }
            .bind(to: output)
            .disposed(by: disposeBag)
    }
}

class ProductionCell1: ZSTableViewCell {
    
    let titleLab: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.groupTableViewBackground
        textView.layer.cornerRadius = 5
        textView.layer.masksToBounds = true
        textView.font = UIFont.systemFont(ofSize: 14)
        return textView
    }()
    
    override func buildSubViews() {
        super.buildSubViews()
        contentView.addSubview(titleLab)
        contentView.addSubview(textView)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        titleLab.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(UIEdgeInsets(top: 30, left: 20, bottom: 10, right: 20))
        }
        
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom).offset(10)
            make.bottom.leading.trailing.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
            make.height.equalTo(30)
        }
        
    }
    
    let input = PublishRelay<ProductionModel>()
    let output = PublishRelay<ProductionModel>()
    
    override func bindViewModel() {
        super.bindViewModel()
        
        input
            .bind{ [weak self] in guard let `self` = self else { return }
                self.titleLab.text = $0.title
                self.textView.text = $0.content
            }
            .disposed(by: disposeBag)
        
        textView.rx.text.orEmpty
            .skip(1)
            .debounce(1.0, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .map{ ProductionModel(content: $0) }
            .bind(to: output)
            .disposed(by: disposeBag)
    }
}

