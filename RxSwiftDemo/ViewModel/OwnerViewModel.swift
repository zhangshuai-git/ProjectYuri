//
//  OwnerViewModel.swift
//  RxSwiftDemo
//
//  Created by 張帥 on 2019/01/17.
//  Copyright © 2019 張帥. All rights reserved.
//

import RxCocoa
import RxSwift

class OwnerViewModel: ViewModelType {
    var disposeBag = DisposeBag()
    
    var dataSource = BehaviorRelay(value: RepositoryOwner())
    
    func activate(_ action: ()) { }
}
