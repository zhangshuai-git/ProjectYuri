//
//  DataBaseService.swift
//  RxSwiftDemo
//
//  Created by 張帥 on 2019/01/17.
//  Copyright © 2019 張帥. All rights reserved.
//

import RxCocoa
import RxSwift

class DatabaseService {
    static let shared = DatabaseService()
    private init() {
        getAllRepository().bind(to: repositories).disposed(by: disposeBag)
    }
    
    let disposeBag = DisposeBag()
    
    let repositories = BehaviorRelay(value: [Repository]())
    
    func add(repository : Repository) {
        Observable<Void>
            .create({ (subscriber) -> Disposable in
                DatabaseAPI.shared.add(repository: repository)
                subscriber.onNext(())
                subscriber.onCompleted()
                return Disposables.create()
            })
            .flatMapLatest {
                self.getAllRepository()
            }
            .bind(to: repositories)
            .disposed(by: disposeBag)
    }
    
    func delete(repository: Repository) {
        Observable<Void>
            .create({ (subscriber) -> Disposable in
                DatabaseAPI.shared.delete(repository: repository)
                subscriber.onNext(())
                subscriber.onCompleted()
                return Disposables.create()
            })
            .flatMapLatest {
                self.getAllRepository()
            }
            .bind(to: repositories)
            .disposed(by: disposeBag)
    }
    
    private func getAllRepository() -> Observable<[Repository]> {
        return Observable
            .from(DatabaseAPI.shared.getAllRepository())
            .map({
                $0.isSubscribed = true
                return $0
            })
            .toArray()
    }
}
