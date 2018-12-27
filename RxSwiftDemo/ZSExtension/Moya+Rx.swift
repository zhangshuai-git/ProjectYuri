//
//  Moya+Rx.swift
//  RxSwiftDemo
//
//  Created by 張帥 on 2018/12/26.
//  Copyright © 2018 張帥. All rights reserved.
//

import Foundation

//public extension Reactive where Base: MoyaProviderType {
//
//    /// Designated request-making method.
//    ///
//    /// - Parameters:
//    ///   - token: Entity, which provides specifications necessary for a `MoyaProvider`.
//    ///   - callbackQueue: Callback queue. If nil - queue from provider initializer will be used.
//    /// - Returns: Single response object.
//    public func requestWithCache(_ token: Base.Target, callbackQueue: DispatchQueue? = nil) -> Single<Response> {
//        return Single.create { [weak base] single in
//
//            //拼接成为数据库的key
//            var key = token.baseURL.absoluteString + token.path
//            //            var key = token.baseURL.absoluteString + token.path
//            if token.parameters != nil {
//                key += (base?.toJSONString(dict: token.parameters))!
//            }
//
//            //建立Realm
//            let realm = try! Realm()
//            print(realm.configuration.fileURL)
//            //设置过滤条件
//            let pre = NSPredicate(format: "key = %@",key)
//
//            //过滤出来的数据(为数组)
//            let ewresponse = realm.objects(ResultModel.self).filter(pre)
//
//            //先看有无缓存的话，如果有数据，数组即不为0
//            if ewresponse.count != 0 {
//                //因为设置了过滤条件，只会出现一个数据,直接取
//                let filterResult = ewresponse[0]
//                //重新创建成Response发送出去
//                let creatResponse = Response(statusCode: filterResult.statuCode, data: filterResult.data!)
//                observer.onNext(creatResponse)
//            }
//
//            let cancellableToken = base?.request(token, callbackQueue: callbackQueue, progress: nil) { result in
//                switch result {
//                case let .success(response):
//                    single(.success(response))
//                case let .failure(error):
//                    single(.error(error))
//                }
//            }
//
//            return Disposables.create {
//                cancellableToken?.cancel()
//            }
//        }
//    }
//
//}
