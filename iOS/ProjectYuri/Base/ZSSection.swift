//
//  ZSSection.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/03/29.
//  Copyright © 2019 張帥. All rights reserved.
//

import Foundation
import RxDataSources
import HandyJSON

class ZSEntity<T> {
    var clazz: T.Type
    var data: Any
    
    init(_ clazz: T.Type, _ data: Any) {
        self.clazz = clazz
        self.data = data
    }
}
