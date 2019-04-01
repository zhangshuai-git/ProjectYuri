//
//  ProductionViewController.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/03/28.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

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
        tableView.zs.register(ProductionCell.self)
//        tableView.zs.register(ProductionCell1.self)
        return tableView
    }()
    
    let headerView: ProductionHeaderView = {
        let headerView = ProductionHeaderView()
        let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        headerView.frame = CGRect(x: 0, y: 0, width: 0, height: height)
        return headerView
    }()
    
    override func buildSubViews() {
        super.buildSubViews()
        view.addSubview(tableView)
        tableView.tableHeaderView = headerView
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        tableView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(topLayoutGuide.snp.bottom)
            make.bottom.equalTo(bottomLayoutGuide.snp.top)
        }
    }
    
    let dataSource = BehaviorRelay(value: Repository())
    
    lazy var sectionedDataSource: Observable<[SectionModel<String, Any>]> = dataSource
        .map {
            return [
                SectionModel(model: "介绍", items: [$0.desp]),
                SectionModel(model: "信息", items: [$0.htmlUrl]),
                SectionModel(model: "制作人员", items: [$0.owner]),
                SectionModel(model: "角色", items: [$0.owner])
            ]
        }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        sectionedDataSource
            .bind(to: tableView.rx.items(dataSource: RxTableViewSectionedReloadDataSource(
                configureCell: { (dataSource, tableView, indexPath, element) in
//                    switch indexPath.section {
//                    case 0:
//                        let cell = tableView.zs.dequeueReusableCell(ProductionCell.self, for: indexPath)
//                        Observable.of(element).bind(to: cell.dataSource).disposed(by: cell.disposeBag)
//                        return cell
//                    case 1:
//                        let cell = tableView.zs.dequeueReusableCell(ProductionCell1.self, for: indexPath)
//                        Observable.of(element).bind(to: cell.dataSource).disposed(by: cell.disposeBag)
//                        return cell
//                    default: return UITableViewCell()
//                    }
                    let cell = tableView.zs.dequeueReusableCell(ProductionCell.self, for: indexPath)
                    Observable.of(element).bind(to: cell.dataSource).disposed(by: cell.disposeBag)
                    return cell
                },
                titleForHeaderInSection: { dataSource, sectionIndex in
                    return dataSource[sectionIndex].model
                }
            )))
            .disposed(by: disposeBag)
        
//        dataSource
//            .bind(to: tableView.rx.items) { tableView, row, element in
//                let cell = tableView.zs.dequeueReusableCell(SearchTableViewCell.self, for: IndexPath(row: row, section: 0))
//                Observable.of(element).bind(to: cell.dataSource).disposed(by: cell.disposeBag)
//                return cell
//            }
//            .disposed(by: disposeBag)
        
    }

}

//extension ProductionViewController: UITableViewDelegate, UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 4
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        switch indexPath.section {
//        case 0:
//            let cell = tableView.zs.dequeueReusableCell(ProductionCell.self, for: indexPath)
//            Observable.of(element).bind(to: cell.dataSource).disposed(by: cell.disposeBag)
//            return cell
//        case 1:
//            let cell = tableView.zs.dequeueReusableCell(ProductionCell1.self, for: indexPath)
//            Observable.of(element).bind(to: cell.dataSource).disposed(by: cell.disposeBag)
//            return cell
//        default: return UITableViewCell()
//        }
//    }
//
//}
