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
        label.text = "作品中文名"
        label.font = UIFont.systemFont(ofSize: 16)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.groupTableViewBackground
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = true
        textField.placeholder = "例如:无夜国度"
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
    
    let dataSource = PublishRelay<ProductionModel>()
    let action = BehaviorRelay(value: Production())
    
    override func bindViewModel() {
        super.bindViewModel()
        
        textField.rx.text.orEmpty
            .skip(1)
            .debounce(1.0, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind{ [weak self] in guard let `self` = self else { return }
                self.action.value.nameCN = $0
            }
            .disposed(by: disposeBag)
    }
}
