//
//  NetworkService.swift
//  RxSwiftDemo
//
//  Created by 張帥 on 2018/12/10.
//  Copyright © 2018 張帥. All rights reserved.
//

import RxSwift
import RxCocoa
import Moya

class NetworkService {
    static let shared = NetworkService()
    private init() {}
    
    func searchRepositories(_ params:RepositoriesParams) -> Observable<GitHubRepositories> {
        return GitHubProvider.rx
            .request(.repositories(params.toJSON() ?? [:]))
            .asObservable()
            .mapModel(GitHubRepositories.self)
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .default))
            .observeOn(MainScheduler.instance)
    }
}
