//
//  NetworkService.swift
//  RxSwiftDemo
//
//  Created by 張帥 on 2018/12/10.
//  Copyright © 2018 張帥. All rights reserved.
//

import RxSwift
import RxCocoa

class NetworkService {
    static let shared = NetworkService()
    private init() {}
    
    func getRandomResult(_ count: Int = 20) -> Observable<[String]> {
        return Observable<[String]>.create { (observer) -> Disposable in
            print("Requesting Data ......")
            let items = (0..<count).map { (_) in
                "\(Int(arc4random()))"
            }
            print("Request Data Success")
            
            observer.onNext(items)
            observer.onCompleted()
            return Disposables.create()
            }
            .delay(2, scheduler: ConcurrentDispatchQueueScheduler.init(qos: .default))
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .default))
            .observeOn(MainScheduler.instance)
    }
}
