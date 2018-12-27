//
//  BaseViewController.swift
//  SwiftDemo
//
//  Created by 張帥 on 2018/11/30.
//  Copyright © 2018 張帥. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, ViewType {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        buildSubViews(view)
        makeConstraints()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reBindViewModel()
    }

//    func buildSubViews() -> Void { }
    func makeConstraints() -> Void { }
    func bindViewModel() -> Void { }
    func reBindViewModel() -> Void { }
    
    func buildSubViews(_ rootView: UIView) { }
//    func bindViewModel(_ viewModel: ViewModel) { }
//    func reBindViewModel(_ viewModel: ViewModelType) -> Void { }
}
