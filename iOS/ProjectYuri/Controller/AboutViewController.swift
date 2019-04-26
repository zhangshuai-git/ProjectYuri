//
//  AboutViewController.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/04/25.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ZSUtils

class AboutViewController: ZSViewController {

    let tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.estimatedRowHeight = 44.0
        tableView.estimatedSectionHeaderHeight = 24.0
        tableView.estimatedSectionFooterHeight = 24.0
        tableView.zs.register(MeCell.self)
        return tableView
    }()
    
    override func buildSubViews() {
        super.buildSubViews()
        view.addSubview(tableView)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(topLayoutGuide.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(bottomLayoutGuide.snp.top)
        }
        
    }
    
    lazy var dataSource: BehaviorRelay<[MeModel]> = BehaviorRelay(value: [
        MeModel("当前版本", desp: UIDevice.appVersion()),
        MeModel("开源组件许可", selectedAction:{ [weak self] in
            self?.gotoLicenseViewController("开源组件许可")
        }),
        MeModel("制作人名单"),
        ])
    
    override func bindViewModel() {
        super.bindViewModel()
        
        dataSource
            .bind(to: tableView.rx.items) { tableView, row, element in
                let indexPath = IndexPath(row: row, section: 0)
                let cell = tableView.zs.dequeueReusableCell(MeCell.self, for: indexPath)
                Observable.of(element).bind(to: cell.dataSource).disposed(by: cell.disposeBag)
                return cell
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(MeModel.self)
            .bind { $0.selectedAction?() }
            .disposed(by: disposeBag)
        
    }

}
