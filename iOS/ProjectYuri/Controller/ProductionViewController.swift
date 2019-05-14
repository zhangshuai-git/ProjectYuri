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
        tableView.separatorStyle = .none
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
    
    let input = BehaviorRelay(value: Production())
    let addProductionImageRequest = BehaviorRelay(value: ProductionImageRequest())
    
    lazy var dataSource: Observable<[ProductionModel]> = Observable.of([
        ProductionModel(title: "作品中文名", content: self.input.value.nameCN, detail: "例如:无夜之国"),
        ProductionModel(title: "作品原名", content: self.input.value.name, detail: "例如:よるのないくに"),
        ProductionModel(title: "作品简介", content: self.input.value.desp),
        ProductionModel(title: "作品类别", category: self.input.value.category),
        ProductionModel(title: "上传封面", coverUrl: self.input.value.coverUrl),
        ])
    
    override func bindViewModel() {
        super.bindViewModel()
        
       dataSource
            .bind(to: tableView.rx.items) { tableView, row, element in
                let indexPath = IndexPath(row: row, section: 0)
                switch row {
                case 0:
                    let cell = tableView.zs.dequeueReusableCell(ProductionCell0.self, for: indexPath)
                    Observable.of(element)
                        .bind(to: cell.input)
                        .disposed(by: cell.disposeBag)
                    cell.output
                        .bind{ [weak self] in guard let `self` = self else { return }
                            self.input.value.nameCN = $0.content
                        }
                        .disposed(by: cell.disposeBag)
                    return cell
                case 1:
                    let cell = tableView.zs.dequeueReusableCell(ProductionCell0.self, for: indexPath)
                    Observable.of(element)
                        .bind(to: cell.input)
                        .disposed(by: cell.disposeBag)
                    cell.output
                        .bind{ [weak self] in guard let `self` = self else { return }
                            self.input.value.name = $0.content
                        }
                        .disposed(by: cell.disposeBag)
                    return cell
                case 2:
                    let cell = tableView.zs.dequeueReusableCell(ProductionCell1.self, for: indexPath)
                    Observable.of(element)
                        .bind(to: cell.input)
                        .disposed(by: cell.disposeBag)
                    cell.output
                        .bind{ [weak self] in guard let `self` = self else { return }
                            self.input.value.desp = $0.content
                        }
                        .disposed(by: cell.disposeBag)
                    return cell
                case 3:
                    let cell = tableView.zs.dequeueReusableCell(ProductionCell2.self, for: indexPath)
                    Observable.of(element)
                        .bind(to: cell.input)
                        .disposed(by: cell.disposeBag)
                    cell.output
                        .bind{ [weak self] in guard let `self` = self else { return }
                            self.input.value.category = $0.category
                        }
                        .disposed(by: cell.disposeBag)
                    return cell
                case 4:
                    let cell = tableView.zs.dequeueReusableCell(ProductionCell3.self, for: indexPath)
                    Observable.of(element)
                        .bind(to: cell.input)
                        .disposed(by: cell.disposeBag)
                    cell.output
                        .bind{ [weak self] in guard let `self` = self else { return }
                             self.addProductionImageRequest.value.coverImg = $0.image
                        }
                        .disposed(by: cell.disposeBag)
                    return cell
                default: return UITableViewCell()
                }
            }
            .disposed(by: disposeBag)
        
    }

}
