//
//  ProductionHeaderView.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/03/29.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProductionHeaderView: ZSView {
    
    override func buildSubViews() {
        super.buildSubViews()
        backgroundColor = UIColor.main
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        snp.makeConstraints { (make) in
            make.height.equalTo(100)
        }
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
    }

}

class ProductionSectionHeaderView: ZSView {
    
    let titleLab: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.gray
        label.textAlignment = .center
        return label
    }()
    
    override func buildSubViews() {
        super.buildSubViews()
        addSubview(titleLab)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        titleLab.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalTo(20)
        }
    }
    
    let dataSource = PublishRelay<String>()
    
    override func bindViewModel() {
        super.bindViewModel()
        dataSource
            .bind(to: titleLab.rx.text)
            .disposed(by: disposeBag)
    }
    
}
