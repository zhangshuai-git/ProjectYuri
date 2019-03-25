//
//  SignalType.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/01/17.
//  Copyright © 2019 張帥. All rights reserved.
//

import RxSwift

public protocol DisposableType {
    var disposeBag: DisposeBag { get }
}

public protocol ViewType: DisposableType {
    func buildSubViews()
    func makeConstraints()
    func bindViewModel()
}

public protocol ViewModelType: DisposableType {
    associatedtype Action
    func activate(_ action: Action)
}

