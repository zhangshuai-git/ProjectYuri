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
        
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
    }
    
    let dataSource = PublishRelay<Any>()
    
    override func bindViewModel() {
        super.bindViewModel()
        
    }

}

//class ProductionCell1: ZSExpandableCell {
//    
//     let dataSource = PublishRelay<RepositoryOwner>()
//    
//    override func buildSubViews() {
//        super.buildSubViews()
//        
//    }
//    
//    override func makeConstraints() {
//        super.makeConstraints()
//        
//    }
//    
//    override func bindViewModel() {
//        super.bindViewModel()
//        
//    }
//    
//}


