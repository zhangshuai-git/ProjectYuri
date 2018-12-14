//
//  BaseModel.swift
//  RxSwiftDemo
//
//  Created by 張帥 on 2018/12/11.
//  Copyright © 2018 張帥. All rights reserved.
//

import Foundation

class BaseViewModel/*<ModelType>*/ {
    
    weak var view: UIView?
    var action: PublishSubject<(Any?) -> Void>?
//    var dataSource: BehaviorRelay<ModelType>?
    
    required init() { }
}
