//
//  HomeCellModel.swift
//  RxSwiftDemo
//
//  Created by 張帥 on 2018/12/27.
//  Copyright © 2018 張帥. All rights reserved.
//

import Foundation

class HomeCellModel:ViewModelType {
    
    lazy var dataSource = BehaviorRelay<Repository>(value: Repository())
    
    
}

extension HomeCellModel {
    struct Input {
        let btnTapAction:Observable<Void>
    }
    
    struct Output {
        
    }
    
    func transform(_ input: HomeCellModel.Input) -> HomeCellModel.Output {
        return Output()
    }
}
