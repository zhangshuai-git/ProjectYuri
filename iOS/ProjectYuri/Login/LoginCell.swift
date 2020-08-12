//
//  LoginCell.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/05/23.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class LoginCell: ZSTableViewCell {
    
    let input = BehaviorRelay(value: LoginModel())
    let output = PublishRelay<LoginModel>()
    
    func setData(data: LoginModel) {
        self.textField.text = data.content
        self.textField.placeholder = data.detail
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        input
            .bind(onNext: self.setData)
            .disposed(by: disposeBag)
        
        textField.rx.text.orEmpty
            .skip(1)
            .debounce(1.0, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .map{
                self.input.value.content = $0
                return self.input.value
            }
            .bind(to: output)
            .disposed(by: disposeBag)
    }
    
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
        contentView.addSubview(textField)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        textField.snp.makeConstraints { (make) in
            make.top.bottom.leading.trailing.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
            make.height.equalTo(30)
        }
    }
}
