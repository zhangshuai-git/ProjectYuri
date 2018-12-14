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

//class NetworkService {
//    static let shared = NetworkService()
//    private init() {}
//
//    func getRandomResult(_ count: Int = 20) -> Observable<[HomeModel]> {
//        return Observable<[HomeModel]>.create { (observer) -> Disposable in
//            print("Requesting Data ......")
//            let items: [HomeModel] = (0..<count).map { _ in
//                let model = HomeModel()
//                model.description = "\(Int(arc4random()))"
//                return model
//            }
//            print("Request Data Success")
//
//            observer.onNext(items)
//            observer.onCompleted()
//            return Disposables.create()
//            }
//            .delay(2, scheduler: ConcurrentDispatchQueueScheduler.init(qos: .default))
//            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .default))
//            .observeOn(MainScheduler.instance)
//    }
//}

class NetworkService {
    static let shared = NetworkService()
    private init() {}
    
    func searchRepositories(query:String) -> Observable<GitHubRepositories> {
        return GitHubProvider.rx
            .request(.repositories(query))
            .asObservable()
            .filterSuccessfulStatusCodes()
            .mapModel(GitHubRepositories.self)
            .catchError({ error in
                print("发生错误：",error.localizedDescription)
                return Observable<GitHubRepositories>.empty()
            })
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .default))
            .observeOn(MainScheduler.instance)
    }
}
