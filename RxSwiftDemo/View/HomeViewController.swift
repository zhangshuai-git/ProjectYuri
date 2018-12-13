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

class HomeViewController: BaseViewController<HomeViewModel> {
    
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
//        tableView.mj_header = MJRefreshNormalHeader()
//        tableView.mj_footer = MJRefreshAutoNormalFooter()
        return tableView
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        let height: CGFloat = searchBar.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        searchBar.frame = CGRect(x: 0, y: 0, width: 0, height: height);
        return searchBar
    }()
    
    override func buildSubViews() {
        view.addSubview(tableView)
//        tableView.tableHeaderView = searchBar
        navigationItem.titleView = searchBar
    }
    
    override func makeConstraints() -> Void {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override func bindViewModel(_ viewModel: HomeViewModel?) {
        let searchAction:Observable<String> = searchBar.rx.text
            .orEmpty
            .throttle(1.0, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .asObservable()
        
        let searchResult:Observable<GitHubRepositories> = searchAction
            .filter { !$0.isEmpty }
            .flatMapLatest{
                return GitHubNetworkService.shared.searchRepositories(query: $0)
            }
            .share(replay: 1)
        
        let cleanResult = searchAction
            .filter{ $0.isEmpty }
            .map{ _ in Void() }
        
        let repositories:Observable<[GitHubRepository]> = Observable
            .of(searchResult.map{ $0.items }, cleanResult.map{[]})
            .merge()
        
        repositories
            .bind(to: tableView.rx.items) { tableView, row, element in
                let cell = tableView.zs.dequeueReusableCell(HomeTableViewCell.self, for: IndexPath(row: row, section: 0))
                cell.titleLab.text = element.name ?? ""
                cell.detailLab.text = element.html_url ?? ""
                return cell
            }
            .disposed(by: disposedBag)
        
        tableView.rx.modelSelected(GitHubRepository.self)
            .subscribe(onNext: {[weak self] item in
                self?.showAlert(title: item.full_name, message: item.description)
            })
            .disposed(by: disposedBag)
        
//        let newData = tableView.mj_header.rx.refreshing.asObservable()
//            .flatMapLatest { _ in
//                NetworkService.shared.getRandomResult(10).catchErrorJustReturn([])
//            }
//            .share(replay: 1)
//
//        let moreData = tableView.mj_footer.rx.refreshing.asObservable()
//            .flatMapLatest { _ in
//                NetworkService.shared.getRandomResult(10).catchErrorJustReturn([])
//            }.share(replay: 1)
//
//        let dataSource = BehaviorRelay<[HomeModel]>(value: [])
//
//        let footerState: ([HomeModel]) -> RxMJRefreshFooterState = {_ in
//            dataSource.value.count < 30 ? .default : .noMoreData
//        }
//
//        newData
//            .bind(to: dataSource)
//            .disposed(by: disposedBag)
//
//        moreData
//            .map { dataSource.value + $0 }
//            .bind(to: dataSource)
//            .disposed(by: disposedBag)
//
//        newData
//            .map { _ in false }
//            .asDriver(onErrorJustReturn: false)
//            .drive(tableView.mj_header.rx.isRefreshing)
//            .disposed(by: disposedBag)
//
//        Observable
//            .merge(newData.map(footerState), moreData.map(footerState))
//            .startWith(.hidden)
//            .asDriver(onErrorJustReturn: .hidden)
//            .drive(tableView.mj_footer.rx.refreshFooterState)
//            .disposed(by: disposedBag)
//
//        dataSource
//            .skip(1)
//            .bind(to: tableView.rx.items) { table, row, element in
//                let cell = table.zs.dequeueReusableCell(HomeTableViewCell.self, for: IndexPath(row: row, section: 0))
//                cell.titleLab.text = "\(row)、\(String(describing: element.description))"
////                element.number = row
////                let cm = HomeCellModel()
////                cm.dataSource = BehaviorRelay<HomeModel>(value: element)
////                cell.viewModel = cm
//                return cell
//            }
//            .disposed(by: disposedBag)
    }
    
//    override func reBindViewModel() {
//        tableView.mj_header.beginRefreshing()
//    }
    
    func showAlert(title:String, message:String){
        let alertController = UIAlertController(title: title,
                                                message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

