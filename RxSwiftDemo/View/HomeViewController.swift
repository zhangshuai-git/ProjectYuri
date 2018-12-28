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
        label.backgroundColor = UIColor.groupTableViewBackground
        return label
    }()
    
    lazy var emptyView: ZSEmptyView = {
        let emptyView = ZSEmptyView(message: "请输入关键字\n实时搜索GitHub上的repositories\n下拉列表刷新数据，上拉加载更多数据\n点击条目查看详情，点击Owner查看作者信息")
        emptyView.backgroundColor = UIColor.white
        return emptyView
    }()
    
    override func buildSubViews(_ rootView: UIView) {
        navigationItem.titleView = searchBar
        rootView.addSubview(tableView)
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
        
        let input = HomeViewModel.Input(searchAction: searchAction, headerAction: headerAction, footerAction: footerAction)
        
        let output = viewModel.transform(input)
        
        output.dataSourceCount
            .bind(to: resultLab.rx.text)
            .disposed(by: disposeBag)
        
        output.dataSource
            .skip(1)
            .map{ $0.items }
            .bind(to: tableView.rx.items) { tableView, row, element in
                let cell = tableView.zs.dequeueReusableCell(HomeTableViewCell.self, for: IndexPath(row: row, section: 0))
                Observable.of(element).bind(to: cell.viewModel.dataSource).disposed(by: cell.disposeBag)
//                cell.titleLab.text = element.name
//                cell.detailLab.text = element.description
//                cell.contentLab.text = element.htmlUrl
////                cell.isButtonActive = false
//                cell.actionBtn.rx.tap
//                    .asObservable()
//                    .asDriver(onErrorJustReturn: Void())
//                    .drive(onNext: {
////                        cell.isButtonActive.toggle()
//                        print(cell.isButtonActive)
////                        [weak self] in guard let `self` = self else { return }
////                        self.gotoOwnerViewController(element.owner)
//                    }).disposed(by: cell.disposeBag)
                return cell
            }
            .disposed(by: disposeBag)
        
        output.dataSource
            .subscribe(onNext: {
                [weak self] _ in guard let `self` = self else { return }
                self.tableView.zs.reloadData(withEmpty: self.emptyView)
            })
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(GitHubRepository.self)
            .subscribe(onNext: {
                [weak self] in guard let `self` = self else { return }
//                self.showAlert(title: $0.fullName ,message: $0.description)
                self.gotoOwnerViewController($0.owner)
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
}

extension HomeViewController {
    func footerState(_ repositories: GitHubRepositories) -> RxMJRefreshFooterState {
        if repositories.items.count == 0 { return .hidden }
        print("page = \(repositories.currentPage), totalPage = \(repositories.totalPage)")
        return repositories.totalPage == 0 || repositories.currentPage < repositories.totalPage ? .default : .noMoreData
    }
    
//    func showAlert(title:String, message:String) {
//        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//        alertController.addAction(cancelAction)
//        self.present(alertController, animated: true, completion: nil)
//    }
    
    func gotoOwnerViewController(_ owner: RepositoryOwner?) {
        let vc = OwnerViewController()
        vc.owner = owner
        navigationController?.pushViewController(vc, animated: true)
    }
}

