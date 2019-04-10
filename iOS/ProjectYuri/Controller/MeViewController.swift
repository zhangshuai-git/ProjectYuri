//
//  ProfileViewController.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/03/27.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MeViewController: ZSViewController {

    let topView: MeTopView = {
        let view = MeTopView()
        return view
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.estimatedRowHeight = 44.0
        tableView.estimatedSectionHeaderHeight = 24.0
        tableView.estimatedSectionFooterHeight = 24.0
        tableView.zs.register(UITableViewCell.self)
        return tableView
    }()
    
    override func buildSubViews() {
        super.buildSubViews()
//        rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_settings_black")?.toScale(0.7))
        view.addSubview(topView)
        view.addSubview(tableView)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        topView.snp.makeConstraints { (make) in
            make.top.equalTo(topLayoutGuide.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(topView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(bottomLayoutGuide.snp.top)
        }
        
    }
    
    lazy var dataSource: BehaviorRelay<[MeCellModel]> = BehaviorRelay(value: [
        MeCellModel("添加条目", { [weak self] in
            self?.gotoAddProductionViewController()
        }),
        MeCellModel("设置", {}),
        ])
    
    override func bindViewModel() {
        super.bindViewModel()
        
        let topViewTapedAction = UITapGestureRecognizer()
        topView.addGestureRecognizer(topViewTapedAction)
        topViewTapedAction.rx.event
            .bind{ [weak self] _ in
                self?.gotoProfileContainerViewController()
            }
            .disposed(by: disposeBag)
        
//        rightBarButtonItem?.button?.rx.tap
//            .bind{
//                print("\($0) rightBarButtonItem")
//            }
//            .disposed(by: disposeBag)
        
        dataSource
            .bind(to: tableView.rx.items) { tableView, row, element in
                let indexPath = IndexPath(row: row, section: 0)
                let cell = tableView.zs.dequeueReusableCell(UITableViewCell.self, for: indexPath)
                cell.selectionStyle = .none
                cell.accessoryType = .disclosureIndicator
                cell.textLabel?.text = element.title
                return cell
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(MeCellModel.self)
            .bind { $0.selectedAction() }
            .disposed(by: disposeBag)
        
    }
    
}

