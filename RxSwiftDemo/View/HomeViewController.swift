//
//  ViewController.swift
//  RxSwiftDemo
//
//  Created by 張帥 on 2018/12/10.
//  Copyright © 2018 張帥. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: BaseViewController {
    
    let disposedBag = DisposeBag()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.estimatedRowHeight = 44.0
        tableView.estimatedSectionHeaderHeight = 24.0
        tableView.estimatedSectionFooterHeight = 24.0
        tableView.zs.register(HomeTableViewCell.self)
        tableView.mj_header = MJRefreshNormalHeader()
        tableView.mj_footer = MJRefreshAutoNormalFooter()
        return tableView
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        return searchBar
    }()
    
    lazy var resultLab: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    override func buildSubViews() {
        navigationItem.titleView = searchBar
        view.addSubview(tableView)
        tableView.tableHeaderView = resultLab
    }
    
    override func makeConstraints() -> Void {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override func bindViewModel() {
        let viewModel = HomeViewModel(vc: self)
        
        viewModel.newData
            .bind(to: viewModel.dataSource)
            .disposed(by: disposedBag)

        viewModel.moreData
            .map { viewModel.dataSource.value + $0 }
            .bind(to: viewModel.dataSource)
            .disposed(by: disposedBag)

        viewModel.newData
            .map { _ in false }
            .asDriver(onErrorJustReturn: false)
            .drive(tableView.mj_header.rx.isRefreshing)
            .disposed(by: disposedBag)

        Observable
            .merge(viewModel.newData.map(viewModel.footerState), viewModel.moreData.map(viewModel.footerState))
            .startWith(.hidden)
            .asDriver(onErrorJustReturn: .hidden)
            .drive(tableView.mj_footer.rx.refreshFooterState)
            .disposed(by: disposedBag)

        viewModel.totalCount
            .bind(to: resultLab.rx.text)
            .disposed(by: disposedBag)
        
        Observable.of(viewModel.repositories, viewModel.dataSource.skip(1).map{ $0.items })
            .merge()
            .bind(to: tableView.rx.items) { tableView, row, element in
                let cell = tableView.zs.dequeueReusableCell(HomeTableViewCell.self, for: IndexPath(row: row, section: 0))
                cell.titleLab.text = element.name
                cell.detailLab.text = element.html_url
                return cell
            }
            .disposed(by: disposedBag)
        
        tableView.rx.modelSelected(GitHubRepository.self)
            .subscribe(onNext: {[weak self] item in
                self?.showAlert(title: item.full_name , message: item.description )
            })
            .disposed(by: disposedBag)
    }
    
    func showAlert(title:String, message:String){
        let alertController = UIAlertController(title: title,
                                                message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

