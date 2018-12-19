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
    
    let disposeBag = DisposeBag()
    
    let viewModel = HomeViewModel()
    
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
        let searchAction:Observable<String> = searchBar.rx.text.orEmpty
            .throttle(2.0, scheduler: MainScheduler.instance)
            .distinctUntilChanged()

        let headerAction:Observable<String> = tableView.mj_header.rx.refreshing
            .asObservable()
            .map{ [weak self] in self?.searchBar.text ?? "" }

        let footerAction:Observable<String> = tableView.mj_footer.rx.refreshing
            .asObservable()
            .map{ [weak self] in self?.searchBar.text ?? "" }
        
        let input = HomeViewModel.Input(searchAction: searchAction, headerAction: headerAction, footerAction: footerAction
        )
        
        let output = viewModel.transform(input)
        
        output.dataSourceCount
            .bind(to: resultLab.rx.text)
            .disposed(by: disposeBag)
        
        output.dataSource
            .skip(1)
            .map{ $0.items }
            .debug("bind to: tableView")
            .bind(to: tableView.rx.items) { tableView, row, element in
                let cell = tableView.zs.dequeueReusableCell(HomeTableViewCell.self, for: IndexPath(row: row, section: 0))
                cell.titleLab.text = element.name
                cell.detailLab.text = element.htmlUrl
                return cell
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(GitHubRepository.self)
            .subscribe(onNext: {[weak self] item in
                self?.showAlert(title: item.fullName ,message: item.description)
            })
            .disposed(by: disposeBag)
        
        output.newData
            .map{ _ in false }
            .asDriver(onErrorJustReturn: false)
            .drive(tableView.mj_header.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        Observable
            .merge(output.newData.map(footerState), output.moreData.map(footerState))
            .startWith(.hidden)
            .asDriver(onErrorJustReturn: .hidden)
            .drive(tableView.mj_footer.rx.refreshFooterState)
            .disposed(by: disposeBag)
    }
    
    func footerState(_ repositories: GitHubRepositories) -> RxMJRefreshFooterState {
        print("page = \(repositories.currentPage), totalPage = \(repositories.totalPage)")
        return repositories.totalPage == 0 || repositories.currentPage < repositories.totalPage ? .default : .noMoreData
    }
    
    func showAlert(title:String, message:String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

