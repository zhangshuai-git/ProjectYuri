//
//  ProductionView.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/05/13.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ProductionFooterView: ZSView {

    let submittalBtn: UIButton = {
        let button = UIButton()
        button.setTitle("提交", for: .normal)
        button.backgroundColor = UIColor.main
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return button
    }()
    
    override func buildSubViews() {
        super.buildSubViews()
        addSubview(submittalBtn)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        submittalBtn.snp.makeConstraints { (make) in
            make.top.bottom.leading.trailing.equalTo(UIEdgeInsets(top: 30, left: 40, bottom: 40, right: 40))
            make.height.equalTo(40)
        }
    }

}
