//
//  FavouritesViewModel.swift
//  RxSwiftDemo
//
//  Created by 張帥 on 2019/01/11.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class FavouritesViewModel: ViewModelType {
    
    let disposeBag = DisposeBag()
    
    lazy var dataSource = BehaviorRelay<[Repository]>(value: [])
    
}

extension FavouritesViewModel {
    struct Input {
    }
    
    struct Output {
    }
    
    func transform(_ input: FavouritesViewModel.Input) -> FavouritesViewModel.Output {
        Observable
            .of(DataBaseAPI.shared.getAllRepository())
            .bind(to: dataSource)
            .disposed(by: disposeBag)
        
        return Output()
    }
}
