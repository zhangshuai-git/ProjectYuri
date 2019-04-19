//
//  Moya+ZSExtension.swift
//  ProjectYuri
//
//  Created by 張帥 on 2018/12/12.
//  Copyright © 2018 張帥. All rights reserved.
//

import RxSwift
import RxCocoa
import Moya
import HandyJSON

extension ObservableType where E == Response {
    public func mapModel<T: HandyJSON>(_ type: T.Type) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            return Observable.just(response.mapModel(T.self))
        }
    }
}

extension Response {
    func mapModel<T: HandyJSON>(_ type: T.Type) -> T {
        let dict:[String : Any] = (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)) as? [String : Any] ?? [:]
        print(dict)
        return JSONDeserializer<T>.deserializeFrom(dict: dict) ?? T()
    }
}
