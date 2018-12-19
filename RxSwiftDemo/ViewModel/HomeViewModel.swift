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
        
        newData
            //            .filter { $0.items.count > 0 }
            //            .debug("bind to dataSource")
            .bind(to: dataSource)
            .disposed(by: vc.disposeBag)
        
        moreData
            //            .filter { $0.items.count > 0 }
            .debug("footer bind to dataSource")
            .map{
                [weak self] in guard let `self` = self else { return $0 }
                return self.dataSource.value + $0
            }
            .bind(to: dataSource)
            .disposed(by: vc.disposeBag)
        
        newData
//            .filter{ $0.items.count > 0 }
            .subscribe(onNext: {
                [weak self] _ in guard let `self` = self else { return }
//                self.repositoriesParams.value.page = 1
                self.dataSource.value.currentPage = 1
            })
            .disposed(by: vc.disposeBag)

        moreData
//            .filter{ $0.items.count > 0 }
            .subscribe(onNext: {
                [weak self] _ in guard let `self` = self else { return }
//                self.repositoriesParams.value.page += 1
                self.dataSource.value.currentPage += 1
            })
            .disposed(by: vc.disposeBag)
        
        newData
            .map{ _ in false }
            .debug("headerState")
            .asDriver(onErrorJustReturn: false)
            .drive(vc.tableView.mj_header.rx.isRefreshing)
            .disposed(by: vc.disposeBag)
        
        Observable
            .merge(newData.map(footerState), moreData.map(footerState))
            .debug("footerState")
            .startWith(.hidden)
            .asDriver(onErrorJustReturn: .hidden)
            .drive(vc.tableView.mj_footer.rx.refreshFooterState)
            .disposed(by: vc.disposeBag)
        
        Observable.of(searchAction, headerAction)
            .merge()
            .debug("action")
//            .filter{ !$0.isEmpty }
            .map{ query -> RepositoriesParams in
                let params = RepositoriesParams()
                params.query = query
                return params
            }
            .bind(to: newRepositoriesParams)
            .disposed(by: vc.disposeBag)
        
        footerAction
            .debug("footer action")
//            .filter{ !$0.isEmpty }
            .map{ query -> RepositoriesParams in
                print(self.moreRepositoriesParams.value.toJSON())
                self.moreRepositoriesParams.value.query = query
                return self.moreRepositoriesParams.value
            }
            .bind(to: moreRepositoriesParams)
            .disposed(by: vc.disposeBag)
    }
    
    private lazy var searchAction:Observable<String> = vc.searchBar.rx.text.orEmpty
        .throttle(2.0, scheduler: MainScheduler.instance)
        .distinctUntilChanged()
    //        .asObservable()
        .debug("searchAction")
    
    private lazy var headerAction:Observable<String> = vc.tableView.mj_header.rx.refreshing
        .asObservable()
        //        .startWith(())
        //        .flatMap{ self.vc.searchBar.rx.text.orEmpty }
        //        .map{ _ in //[weak self] in
        //            self.vc.searchBar.text ?? ""
        //        }
        .map{ [weak self] in self?.vc.searchBar.text ?? "" }
        .share(replay: 1)
        .debug("headerAction")
    
    private lazy var footerAction:Observable<String> = vc.tableView.mj_footer.rx.refreshing
        .asObservable()
        .map{ [weak self] in self?.vc.searchBar.text ?? "" }
        .share(replay: 1)
        .debug("footerAction")
    
    //    lazy var searchResult:Observable<GitHubRepositories> = searchAction
    //        .filter { !$0.isEmpty }
    //        .flatMapLatest{
    //            NetworkService.shared.searchRepositories(query: $0)
    //        }
    //        .share(replay: 1)
    
    //    private lazy var emptyResult = searchAction
    //        .filter{ $0.isEmpty }
    //        .map{ _ in Void() }
    
    //    lazy var repositories:Observable<[GitHubRepository]> = Observable
    //        .of(searchResult.map{ $0.items }, emptyResult.map{[]})
    //        .merge()
    
    //    lazy var totalCount = Observable.of(
    ////        searchResult.map{ "共有 \($0.total_count) 个结果" },
    //        emptyResult.map{ "" }
    
    //        )
    //        .merge()
    
    lazy var newRepositoriesParams = BehaviorRelay<RepositoriesParams>(value: RepositoriesParams())
    
    lazy var moreRepositoriesParams = BehaviorRelay<RepositoriesParams>(value: RepositoriesParams(page: 2))
    
    //    lazy var newRepositoriesParams:Observable<RepositoriesParams> =
    //        Observable.of(searchAction, headerAction)
    //        .merge()
    ////        .debug("action")
    //        .filter { !$0.isEmpty }
    //        .map{ query -> RepositoriesParams in
    //            let params = RepositoriesParams()
    //            params.query = query
    //            return params
    //        }
    //
    //    lazy var moreRepositoriesParams:Observable<RepositoriesParams> = footerAction
    //        .filter { !$0.isEmpty }
    //        .map{
    //            let params = RepositoriesParams()
    //            params.query = $0
    //            return params
    //        }
    
    //    lazy var newData:Observable<GitHubRepositories> = vc.tableView.mj_header.rx.refreshing.asObservable()
    //        .flatMapLatest { [weak self] _ in
    //            NetworkService.shared.searchRepositories(query: self?.vc.searchBar.text ?? "")
    //        }
    //        .share(replay: 1)
    
    lazy var newData:Observable<GitHubRepositories> = newRepositoriesParams
        .debug("params")
//        .filter{ !$0.query.isEmpty }
//        .map{
//            $0.page = 1
//            return $0
//        }
        .flatMapLatest {
            NetworkService.shared.searchRepositories($0)
        }
        .share(replay: 1)
    
    //    lazy var moreData:Observable<GitHubRepositories> = vc.tableView.mj_footer.rx.refreshing.asObservable()
    //        .flatMapLatest { [weak self] _ in
    //            NetworkService.shared.searchRepositories(query: self?.vc.searchBar.text ?? "", page: (self?.dataSource.value.page ?? 1) + 1)
    //        }
    //        .share(replay: 1)
    
    lazy var moreData:Observable<GitHubRepositories> = moreRepositoriesParams
        //        .map {
        //            [weak self] in guard let `self` = self else { return $0 }
        //            $0.page = self.dataSource.value.page
        //            return $0
        //        }
        .debug("footer params")
//        .filter{ !$0.query.isEmpty }
        .map{
            [weak self] in guard let `self` = self else { return $0 }
            $0.page = self.dataSource.value.currentPage + 1
            return $0
        }
        .flatMapLatest {
            NetworkService.shared.searchRepositories($0)
        }
        .share(replay: 1)
    
    lazy var dataSource = BehaviorRelay<GitHubRepositories>(value: GitHubRepositories())
    
    lazy var dataSouceCount = Observable.of(
        dataSource.filter{ $0.totalCount > 0 }.map{ "共有 \($0.totalCount) 个结果" },
        dataSource.filter{ $0.totalCount == 0 }.map{ _ in "" },
        headerAction.filter{ $0.isEmpty }.map{ _ in "" },
        footerAction.filter{ $0.isEmpty }.map{ _ in "" },
        searchAction.filter{ $0.isEmpty }.map{ _ in "" }
        )
        .merge()
    
    lazy var footerState: (GitHubRepositories) -> RxMJRefreshFooterState = { //repositories in
        //        repositories.items.count < 30 ? .default : .noMoreData
        [weak self] repositories in guard let `self` = self else { return .default }
        print("page = \(repositories.currentPage), totalPage = \(repositories.totalPage)")
        return repositories.totalPage == 0 || repositories.currentPage < repositories.totalPage ? .default : .noMoreData
    }
    
//    func footerState(repositories: GitHubRepositories) -> RxMJRefreshFooterState {
//        print("page = \(repositories.currentPage), totalPage = \(repositories.totalPage)")
//        return repositories.totalPage == 0 || repositories.currentPage < repositories.totalPage ? .default : .noMoreData
//    }
    
}
