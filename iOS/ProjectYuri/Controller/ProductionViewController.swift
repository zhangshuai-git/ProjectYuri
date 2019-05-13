//
//  ProductionViewController.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/05/13.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ProductionViewController: ZSViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.estimatedRowHeight = 44.0
        tableView.estimatedSectionHeaderHeight = 24.0
        tableView.estimatedSectionFooterHeight = 24.0
        tableView.zs.register(ProductionCell0.self)
        tableView.zs.register(ProductionCell1.self)
        tableView.zs.register(ProductionCell2.self)
        tableView.zs.register(ProductionCell3.self)
        return tableView
    }()
    
    let footerView: ProductionFooterView = {
        let footerView = ProductionFooterView()
        let height = footerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        footerView.frame = CGRect(x: 0, y: 0, width: 0, height: height)
        return footerView
    }()

    override func buildSubViews() {
        super.buildSubViews()
        view.addSubview(tableView)
        tableView.tableFooterView = footerView
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        tableView.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
    }

}
