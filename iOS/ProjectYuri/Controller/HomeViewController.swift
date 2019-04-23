//
//  HomeViewController.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/03/27.
//  Copyright © 2019 張帥. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MJRefresh
import ZSUtils

class HomeViewController: ZSViewController {

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
        tableView.mj_header = MJRefreshNormalHeader()
        tableView.mj_footer = MJRefreshAutoNormalFooter()
        return tableView
    }()
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "搜索"
        searchBar.returnKeyType = .done
        return searchBar
    }()
    
    let topView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let categoryArray: [ProductionCategory] = ProductionCategory.allCases
    lazy var groupBtn: UISegmentedControl = {
        let groupBtn = UISegmentedControl(items: ["全部"] + categoryArray.map{$0.displayValue})
        groupBtn.selectedSegmentIndex = 0
        groupBtn.tintColor = UIColor.main
        return groupBtn
    }()
    
    let emptyView = ZSEmptyView()
    
    override func buildSubViews() {
        //        title = "搜索"
        navigationItem.titleView = searchBar
        view.addSubview(topView)
        view.addSubview(tableView)
        topView.addSubview(groupBtn)
    }
    
    override func makeConstraints() -> Void {
        topView.snp.makeConstraints { (make) in
            make.top.equalTo(topLayoutGuide.snp.bottom)
            make.left.right.equalToSuperview()
        }
        
        groupBtn.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
            make.height.equalTo(30)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(bottomLayoutGuide.snp.top)
        }
    }
    
    override func updateViewConstraints() {
        if searchBar.showsCancelButton {
            groupBtn.snp.remakeConstraints { (make) in
                make.edges.equalTo(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
                make.height.equalTo(30)
            }
        } else {
            groupBtn.snp.remakeConstraints { (make) in
                make.edges.equalTo(UIEdgeInsets.zero)
                make.height.equalTo(0)
            }
        }
        super.updateViewConstraints()
    }
    
    let newProductionRequest = BehaviorRelay(value: ProductionRequest())
    
    let moreProductionRequest = BehaviorRelay(value: ProductionRequest(page: 2))
    
    let dataSource = BehaviorRelay(value: PageResult<Production>())

    override func bindViewModel() {
        super.bindViewModel()
        
        let newData:Observable<Result<PageResult<Production>>> = newProductionRequest
            .skip(2)
            .flatMapLatest {
                NetworkService.shared.searchProductions($0)
            }
            .share(replay: 1)
        
        let moreData:Observable<Result<PageResult<Production>>> = moreProductionRequest
            .skip(1)
            .map{ [weak self] in guard let `self` = self else { return $0 }
                $0.page = self.dataSource.value.currentPage + 1
                return $0
            }
            .flatMapLatest {
                NetworkService.shared.searchProductions($0)
            }
            .share(replay: 1)
        
    }
}
