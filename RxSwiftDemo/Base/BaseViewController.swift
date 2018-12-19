//
//  BaseViewController.swift
//  SwiftDemo
//
//  Created by 張帥 on 2018/11/30.
//  Copyright © 2018 張帥. All rights reserved.
//

import UIKit

class BaseViewController/*<ViewModelType>*/: UIViewController, ViewType {
    
//    var viewModel: ViewModelType?ß
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildSubViews()
        makeConstraints()
        bindViewModel()
//        bindViewModel(viewModel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reBindViewModel()
    }

    func buildSubViews() -> Void { }
    func makeConstraints() -> Void { }
    func bindViewModel() -> Void { }
//    func bindViewModel(_ viewModel: ViewModelType?) { }
    func reBindViewModel() -> Void { }
}
