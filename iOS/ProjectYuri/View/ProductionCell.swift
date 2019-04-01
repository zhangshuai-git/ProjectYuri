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

class ProductionCell: ZSExpandableCell {
    override func buildSubViews() {
        super.buildSubViews()
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
    }
}

class ProductionCell0: ProductionCell {
    
    override func buildSubViews() {
        super.buildSubViews()
        
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
    }
    
    let dataSource = PublishRelay<String>()
    
    override func bindViewModel() {
        super.bindViewModel()
        
        dataSource
            .bind {
                print("\($0)")
            }
            .disposed(by: disposeBag)
        
    }

}

class ProductionCell1: ProductionCell {
    
    override func buildSubViews() {
        super.buildSubViews()
        
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
    }
    
    let dataSource = PublishRelay<String>()
    
    override func bindViewModel() {
        super.bindViewModel()
        
    }
    
}

class ProductionCell2: ProductionCell {
    
    override func buildSubViews() {
        super.buildSubViews()
        
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
    }
    
    let dataSource = PublishRelay<RepositoryOwner>()
    
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
    
    let dataSource = PublishRelay<RepositoryOwner>()
    
    override func bindViewModel() {
        super.bindViewModel()
        
    }
    
}


