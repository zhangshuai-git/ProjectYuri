//
//  BaseViewType.swift
//  SwiftDemo
//
//  Created by 張帥 on 2018/11/30.
//  Copyright © 2018 張帥. All rights reserved.
//


public protocol ViewType {
    func buildSubViews()
    func makeConstraints()
    func bindViewModel()
}
