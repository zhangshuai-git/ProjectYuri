//
//  FavouritesViewController.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/01/11.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class FavouritesViewController: ZSViewController {
    
    let dataSource = BehaviorRelay(value: [Repository]())
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.estimatedRowHeight = 44.0
        tableView.estimatedSectionHeaderHeight = 24.0
        tableView.estimatedSectionFooterHeight = 24.0
        tableView.zs.register(SearchTableViewCell.self)
        return tableView
    }()
    
    override func buildSubViews() {
        self.title = "Favourites"
        view.addSubview(tableView)
    }
    
    override func makeConstraints() -> Void {
        tableView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(view.snp.bottomMargin)
        }
    }
    
    override func bindViewModel() {
        dataSource
            .bind(to: tableView.rx.items) { tableView, row, element in
                let cell = tableView.zs.dequeueReusableCell(SearchTableViewCell.self, for: IndexPath(row: row, section: 0))
                Observable.of(element).bind(to: cell.dataSource).disposed(by: cell.disposeBag)
                return cell
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Repository.self)
            .subscribe(onNext: {
                [weak self] in guard let `self` = self else { return }
                self.gotoOwnerViewController(Observable.of($0.owner))
            })
            .disposed(by: disposeBag)
    }
}
