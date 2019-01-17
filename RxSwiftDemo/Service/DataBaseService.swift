//
//  DataBaseService.swift
//  RxSwiftDemo
//
//  Created by 張帥 on 2019/01/17.
//  Copyright © 2019 張帥. All rights reserved.
//

import RxCocoa
import RxSwift

class DataBaseService {
    static let shared = DataBaseService()
    private init() { }
    
    let disposeBag = DisposeBag()
    
    let repositories = BehaviorRelay(value: [Repository]())
    
//    func add(repository : Repository) -> Observable<Void> {
//        let signal = Observable<Void>.create({ (subscriber) -> Disposable in
//            DataBaseAPI.shared.add(repository: repository)
//            subscriber.onNext(())
//            subscriber.onCompleted()
//            return Disposables.create()
//        })
//        signal
//            .bind(to: dataBaseUpdated)
//            .disposed(by: disposeBag)
//        return signal
//    }
//    
//    func delete(repository: Repository) -> Observable<Void> {
//        let signal = Observable<Void>.create({ (subscriber) -> Disposable in
//            DataBaseAPI.shared.delete(repository: repository)
//            subscriber.onNext(())
//            subscriber.onCompleted()
//            return Disposables.create()
//        })
//        signal
//            .bind(to: dataBaseUpdated)
//            .disposed(by: disposeBag)
//        return signal
//    }
    
    func getAllRepository() -> Observable<[Repository]> {
        return Observable.create({ (subscriber) -> Disposable in
            let repositories = DataBaseAPI.shared.getAllRepository()
            for repository in repositories {
                repository.isSubscribed = true
            }
            subscriber.onNext(repositories)
            subscriber.onCompleted()
            return Disposables.create()
        })
    }
}
