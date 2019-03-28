//
//  ProductionViewController.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/03/28.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit

class ProductionViewController: ZSViewController {

    lazy var scrollerContentView = UIView()
    lazy var scrollerView: UIScrollView = {
        let scrollerView = UIScrollView()
        scrollerView.isScrollEnabled = false
        return scrollerView
    }()
    
    override func buildSubViews() {
        view.addSubview(scrollerView)
        scrollerView.addSubview(scrollerContentView)
    }
    
    override func makeConstraints() {
        scrollerView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(view.snp.bottomMargin)
        }
        
        scrollerContentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
    }

}
