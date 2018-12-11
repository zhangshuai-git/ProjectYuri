//
//  ViewController.swift
//  RxSwiftDemo
//
//  Created by 張帥 on 2018/12/10.
//  Copyright © 2018 張帥. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    let disposedBag = DisposeBag()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.sectionFooterHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        tableView.estimatedSectionHeaderHeight = 24.0
        tableView.estimatedSectionFooterHeight = 24.0
        tableView.zs.register(HomeTableViewCell.self)
        tableView.mj_header = MJRefreshNormalHeader()
        tableView.mj_footer = MJRefreshAutoNormalFooter()
        return tableView
    }()
    
    override func buildSubViews() {
        view.addSubview(tableView)
    }
    
    override func makeConstraints() -> Void {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override func bindViewModel() {
        let newData = tableView.mj_header.rx.refreshing.asObservable()
            .flatMapLatest { _ in
                NetworkService.shared.getRandomResult(10).catchErrorJustReturn([])
            }
            .share(replay: 1)
        
        let moreData = tableView.mj_footer.rx.refreshing.asObservable()
            .flatMapLatest { _ in
                NetworkService.shared.getRandomResult(10).catchErrorJustReturn([])
            }.share(replay: 1)
        
        let dataSource = BehaviorRelay<[String]>(value: [])
        
        let footerState: ([String]) -> RxMJRefreshFooterState = {_ in
            dataSource.value.count < 30 ? .default : .noMoreData
        }
        
        newData
            .bind(to: dataSource)
            .disposed(by: disposedBag)
        
        moreData
            .map { dataSource.value + $0 }
            .bind(to: dataSource)
            .disposed(by: disposedBag)
        
        newData
            .map { _ in false }
            .asDriver(onErrorJustReturn: false)
            .drive(tableView.mj_header.rx.isRefreshing)
            .disposed(by: disposedBag)
        
        Observable
            .merge(newData.map(footerState), moreData.map(footerState))
            .startWith(.hidden)
            .asDriver(onErrorJustReturn: .hidden)
            .drive(tableView.mj_footer.rx.refreshFooterState)
            .disposed(by: disposedBag)
        
        dataSource
            .skip(1)
            .bind(to: tableView.rx.items) { table, row, element in
                let cell = table.zs.dequeueReusableCell(HomeTableViewCell.self, for: IndexPath(row: row, section: 0))
                cell.titleLab.text = "\(row)、\(element)"
                return cell
            }
            .disposed(by: disposedBag)
    }
    
    override func reBindViewModel() {
        tableView.mj_header.beginRefreshing()
    }
    
}

