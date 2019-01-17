//
//  ViewModelType.swift
//  RxSwiftDemo
//
//  Created by 張帥 on 2018/12/19.
//  Copyright © 2018 張帥. All rights reserved.
//

public protocol ViewModelType: DisposableType {
    associatedtype Action
    func activate(_ action: Action)
}
