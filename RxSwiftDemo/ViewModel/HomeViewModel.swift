//
//  HomeViewModel.swift
//  RxSwiftDemo
//
//  Created by 張帥 on 2018/12/11.
//  Copyright © 2018 張帥. All rights reserved.
//

import UIKit

//class HomeViewModel: BaseViewModel<[HomeCellModel]> {
//
//}

class HomeViewModel {
    
    let vc: HomeViewController
    init(vc: HomeViewController) {
        self.vc = vc
    }
    
    private lazy var searchAction:Observable<String> = vc.searchBar.rx.text
        .orEmpty
        .throttle(1.0, scheduler: MainScheduler.instance)
        .distinctUntilChanged()
        .asObservable()
    
    private lazy var searchResult:Observable<GitHubRepositories> = searchAction
        .filter { !$0.isEmpty }
        .flatMapLatest{
            NetworkService.shared.searchRepositories(query: $0)
        }
        .share(replay: 1)
    
    private lazy var emptyResult = searchAction
        .filter{ $0.isEmpty }
        .map{ _ in Void() }
    
    lazy var repositories:Observable<[GitHubRepository]> = Observable
        .of(searchResult.map{ $0.items }, emptyResult.map{[]})
        .merge()
    
    lazy var totalCount =  Observable.of(
        searchResult.map{ "共有 \($0.total_count) 个结果" },
        emptyResult.map{ "" },
        dataSource.map{ "共有 \($0.total_count) 个结果" }
        )
        .merge()
    
    lazy var newData:Observable<GitHubRepositories> = vc.tableView.mj_header.rx.refreshing.asObservable()
        .flatMapLatest { [weak self] _ in
            NetworkService.shared.searchRepositories(query: self?.vc.searchBar.text ?? "")
        }
        .share(replay: 1)
    
    lazy var moreData:Observable<GitHubRepositories> = vc.tableView.mj_footer.rx.refreshing.asObservable()
        .flatMapLatest { [weak self] _ in
            NetworkService.shared.searchRepositories(query: self?.vc.searchBar.text ?? "")
        }.share(replay: 1)
    
    lazy var dataSource = BehaviorRelay<GitHubRepositories>(value: GitHubRepositories())
    
    lazy var footerState: (GitHubRepositories) -> RxMJRefreshFooterState = { repositories in
        repositories.items.count < 30 ? .default : .noMoreData
    }
}
