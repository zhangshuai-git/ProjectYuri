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
    
    func getAllRepository() -> Observable<[Repository]> {
        return Observable.create({
            let repositories = DataBaseAPI.shared.getAllRepository()
            for repository in repositories {
                repository.isSubscribed = true
            }
            $0.onNext(repositories)
            $0.onCompleted()
            return Disposables.create()
        })
    }
}
