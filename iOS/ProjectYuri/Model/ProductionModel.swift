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

enum ProductionCategory: String, CaseIterable {
    case game = "游戏"
    case anime = "动画"
    case comic = "漫画"
    case novel = "小说"
}

class ProductionCellModel<T> {
    var isExpanded: Bool = false
    var data: T
    
    init(_ data: T) {
        self.data = data
    }
}


