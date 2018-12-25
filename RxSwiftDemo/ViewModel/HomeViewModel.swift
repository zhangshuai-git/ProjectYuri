//
//  HomeViewModel.swift
//  RxSwiftDemo
//
//  Created by 張帥 on 2018/12/11.
//  Copyright © 2018 張帥. All rights reserved.
//

import UIKit

class HomeViewModel:ViewModelType {
    
    let disposeBag = DisposeBag()
    
    private lazy var newRepositoriesParams = BehaviorRelay<RepositoriesParams>(value: RepositoriesParams())
    
    private lazy var moreRepositoriesParams = BehaviorRelay<RepositoriesParams>(value: RepositoriesParams(page: 2))
    
    private lazy var newData:Observable<GitHubRepositories> = newRepositoriesParams
        .skip(1)
        .flatMapLatest {
            NetworkService.shared.searchRepositories($0)
        }
        .share(replay: 1)
    
    private lazy var moreData:Observable<GitHubRepositories> = moreRepositoriesParams
        .skip(1)
        .map{
            [weak self] in guard let `self` = self else { return $0 }
            $0.page = self.dataSource.value.currentPage + 1
            return $0
        }
        .flatMapLatest {
            NetworkService.shared.searchRepositories($0)
        }
        .share(replay: 1)
    
    private lazy var dataSource = BehaviorRelay<GitHubRepositories>(value: GitHubRepositories())
    
    private lazy var dataSourceCount = Observable.merge(
        dataSource.filter{ $0.totalCount > 0 }.map{ "共有 \($0.totalCount) 个结果" },
        dataSource.filter{ $0.totalCount == 0 }.map{ _ in "未搜索到结果或请求太频繁请稍后再试" },
        newRepositoriesParams.filter{ $0.query.isEmpty }.map{ _ in "" },
        moreRepositoriesParams.filter{ $0.query.isEmpty }.map{ _ in "" }
        )
}

extension HomeViewModel {
    struct Input {
        let searchAction:Observable<String>
        let headerAction:Observable<String>
        let footerAction:Observable<String>
    }
    
    struct Output {
        let newData:Observable<GitHubRepositories>
        let moreData:Observable<GitHubRepositories>
        let dataSource:BehaviorRelay<GitHubRepositories>
        let dataSourceCount:Observable<String>
    }
}

extension HomeViewModel {
    func transform(_ input: HomeViewModel.Input) -> HomeViewModel.Output {
        Observable
            .merge(input.searchAction, input.headerAction)
            .map{ RepositoriesParams(query: $0) }
            .bind(to: newRepositoriesParams)
            .disposed(by: disposeBag)
        
        input.footerAction
            .map{
                self.moreRepositoriesParams.value.query = $0
                return self.moreRepositoriesParams.value
            }
            .bind(to: moreRepositoriesParams)
            .disposed(by: disposeBag)
        
        newData
            .bind(to: dataSource)
            .disposed(by: disposeBag)
        
        moreData
            .map{
                [weak self] in guard let `self` = self else { return $0 }
                return self.dataSource.value + $0
            }
            .bind(to: dataSource)
            .disposed(by: disposeBag)
        
        newData
            .filter{ $0.items.count > 0 }
            .subscribe(onNext: {
                [weak self] _ in guard let `self` = self else { return }
                self.dataSource.value.currentPage = 1
            })
            .disposed(by: disposeBag)
        
        moreData
            .filter{ $0.items.count > 0 }
            .subscribe(onNext: {
                [weak self] _ in guard let `self` = self else { return }
                self.dataSource.value.currentPage += 1
            })
            .disposed(by: disposeBag)
        
        return Output(newData: newData, moreData: moreData, dataSource: dataSource, dataSourceCount: dataSourceCount)
    }
}


