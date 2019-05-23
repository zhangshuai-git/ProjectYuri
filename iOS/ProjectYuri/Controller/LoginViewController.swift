//
//  LoginViewController.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/05/23.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ZSUtils

class LoginViewController: ZSViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.estimatedRowHeight = 44.0
        tableView.estimatedSectionHeaderHeight = 24.0
        tableView.estimatedSectionFooterHeight = 24.0
        tableView.separatorStyle = .none
        tableView.zs.register(LoginCell.self)
        return tableView
    }()
    
    let headerView: LoginHeaderView = {
        let headerView = LoginHeaderView()
        let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        headerView.frame = CGRect(x: 0, y: 0, width: 0, height: height)
        return headerView
    }()
    
    let footerView: LoginFooterView = {
        let footerView = LoginFooterView()
        let height = footerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        footerView.frame = CGRect(x: 0, y: 0, width: 0, height: height)
        return footerView
    }()
    
    override func buildSubViews() {
        super.buildSubViews()
        view.addSubview(tableView)
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footerView
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        tableView.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    let dataSource: BehaviorRelay<[LoginModel]> = BehaviorRelay(value: [
        LoginModel(detail: "用户名"),
        LoginModel(detail: "密码"),
        ])
    
    override func bindViewModel() {
        super.bindViewModel()
        
        dataSource
            .bind(to: tableView.rx.items) { tableView, row, element in
                let indexPath = IndexPath(row: row, section: 0)
                let cell = tableView.zs.dequeueReusableCell(LoginCell.self, for: indexPath)
                Observable.of(element)
                    .bind(to: cell.input)
                    .disposed(by: cell.disposeBag)
                cell.output
                    .bind{ [weak self] in guard let `self` = self else { return }
                        print($0)
                        print(self)
                    }
                    .disposed(by: cell.disposeBag)
                return cell
            }
            .disposed(by: disposeBag)
        
        tableView.rx.didScroll
            .bind{ [weak self] in guard let `self` = self else { return }
                self.view.endEditing(true)
            }
            .disposed(by: disposeBag)
        
    }
    
}
