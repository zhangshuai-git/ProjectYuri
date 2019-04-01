//
//  ProductionCell.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/03/29.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProductionCellModel<T> {
    var isExpanded: Bool = false
    var data: T
    
    init(_ data: T) {
        self.data = data
    }
}

class ProductionCell: ZSExpandableCell {
    
    let dataSource = PublishRelay<ProductionCellModel<Repository>>()
    
    override func buildSubViews() {
        super.buildSubViews()
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
        expandBtn.backgroundColor = .clear
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        dataSource
            .bind { [weak self] in guard let `self` = self else { return }
                self.isExpanded = $0.isExpanded
        }
        .disposed(by: disposeBag)
    }
}

class ProductionCell0: ProductionCell {
    
    let contentLab: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.white
        label.numberOfLines = 0
        return label
    }()
    
    override func buildSubViews() {
        super.buildSubViews()
        expandableView.addSubview(contentLab)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        contentLab.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
        }
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        dataSource
            .map{ $0.data }
            .map{"\($0.desp) \($0.desp) \($0.desp) \($0.desp) \n\n\($0.desp) \($0.desp) \($0.desp) \($0.desp)"}
            .bind(to:contentLab.rx.text)
            .disposed(by: disposeBag)
    }

}

class ProductionCell1: ProductionCell {
    
    let contentLab: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.white
        label.numberOfLines = 0
        return label
    }()
    
    override func buildSubViews() {
        super.buildSubViews()
        expandableView.addSubview(contentLab)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        contentLab.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
        }
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        dataSource
            .map{ $0.data }
            .map{"\($0.htmlUrl) \n\n\($0.htmlUrl) \n\n\($0.htmlUrl) \n\n\($0.htmlUrl) \n\n\($0.htmlUrl) \n\n\($0.htmlUrl) \n\n\($0.htmlUrl) \n\n\($0.htmlUrl)"}
            .bind(to:contentLab.rx.text)
            .disposed(by: disposeBag)
    }
    
}

class ProductionCell2: ProductionCell {
    
    override func buildSubViews() {
        super.buildSubViews()
        
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
    }
    
}

class ProductionCell3: ProductionCell {
    
    override func buildSubViews() {
        super.buildSubViews()
        
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
    }
    
}


