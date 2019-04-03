//
//  ZSView.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/03/28.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ZSView: UIView {

    let disposeBag = DisposeBag()
    
    init() {
        super.init(frame: CGRect.zero)
        buildSubViews()
        makeConstraints()
        bindViewModel()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        buildSubViews()
        makeConstraints()
        bindViewModel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildSubViews() { }
    func makeConstraints() { }
    func bindViewModel() { }
    
    deinit {
        print("deinit \(self)")
    }
}
