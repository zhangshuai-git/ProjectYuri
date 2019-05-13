//
//  HomeModel.swift
//  ProjectYuri
//
//  Created by 張帥 on 2018/12/11.
//  Copyright © 2018 張帥. All rights reserved.
//

import HandyJSON
import RxSwift
import RxCocoa

class ProductionModel {
    var title: String
    var content: String
    var detail: String
    
    init(title: String = "", content: String = "", detail: String = "") {
        self.title = title
        self.content = content
        self.detail = detail
    }
}

class ProductionDetailModel<T> {
    var isExpanded: Bool = false
    var data: T
    
    init(_ data: T) {
        self.data = data
    }
}

class MeModel {
    var title: String
    var desp: String?
    var selectedAction: (() -> Void)?
    
    init(_ title: String, desp: String? = nil, selectedAction: (() -> Void)? = nil) {
        self.title = title
        self.desp = desp
        self.selectedAction = selectedAction
    }
}

