//
//  ViewModelType.swift
//  RxSwiftDemo
//
//  Created by 張帥 on 2018/12/19.
//  Copyright © 2018 張帥. All rights reserved.
//

import Foundation

public protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(_ input: Input) -> Output
}
