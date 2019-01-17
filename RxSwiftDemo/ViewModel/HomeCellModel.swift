//
//  HomeCellModel.swift
//  RxSwiftDemo
//
//  Created by 張帥 on 2019/01/17.
//  Copyright © 2019 張帥. All rights reserved.
//

import RxSwift
import RxCocoa

class HomeCellModel: ViewModelType {
    
    let disposeBag = DisposeBag()
    
    lazy var dataSource = BehaviorRelay(value: Repository())
    
    lazy var isSubscribed = BehaviorRelay(value: false)
    
    func activate(_ subscribeAction: Observable<Bool>) {
        subscribeAction
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: {
                [weak self] in guard let `self` = self else { return }
                print($0)
                self.dataSource.value.isSubscribed = $0
                $0 ? DataBaseAPI.shared.add(repository: self.dataSource.value)
                    : DataBaseAPI.shared.delete(repository: self.dataSource.value)
            })
            .disposed(by: disposeBag)
    }
}

//extension HomeCellModel {
//    struct Actions {
//        let subscribeAction: Observable<Bool>
//    }
    
    
        
        
//        input.element?
//        .bind(to: dataSource)
//        .disposed(by: disposeBag)
    
//}
