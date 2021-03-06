//
//  NetworkService.swift
//  ProjectYuri
//
//  Created by 張帥 on 2018/12/10.
//  Copyright © 2018 張帥. All rights reserved.
//

import RxSwift
import RxCocoa
import Moya
import Alamofire
import SVProgressHUD

class NetworkService {
    static let shared = NetworkService()
    private init() {
        indicator
            .asObservable()
            .subscribe(onNext: {
                $0 ? SVProgressHUD.show() : SVProgressHUD.dismiss()
            })
            .disposed(by: disposeBag)
    }
    
    let disposeBag = DisposeBag()
    
    private let indicator = ActivityIndicator()
    
    private var manager: Alamofire.SessionManager {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        let manager = Alamofire.SessionManager(configuration: configuration)
        return manager
    }

    private var plugins: [PluginType] {
        var plugins: [PluginType] = []
        #if DEBUG
        plugins.append(NetworkLoggerPlugin(verbose: true))
        #endif
        return plugins
    }

    private lazy var moya = MoyaProvider<ProjectYuriAPI>(manager: manager, plugins: plugins)
    
    func searchProductions(_ request:ProductionRequest) -> Observable<Result<PageResult<Production>>> {
        return moya.rx
            .request(.findAllProductions(request.toJSON() ?? [:]))
            .trackActivity(indicator)
            .asObservable()
            .mapModel(Result.self)
            .catchErrorJustReturn(Result())
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .default))
            .observeOn(MainScheduler.instance)
    }
    
    func addProduction(_ request:Production, _ imageRequest: ProductionImageRequest) -> Observable<Result<Production>> {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd_HH-mm-ss_SSS"
        let formDataArray: [Moya.MultipartFormData] = [imageRequest.coverImg?.jpegData(compressionQuality: 0.5)]
            .map{
                let fileName = "\(formatter.string(from: Date())).jpg"
                return MultipartFormData(provider: .data($0 ?? Data()), name: "image", fileName: fileName, mimeType:"image/jpg")
            }
        let param = ["param" : request.toJSONString() ?? ""]
        return moya.rx
            .request(.addProduction(formDataArray, param))
            .trackActivity(indicator)
            .asObservable()
            .mapModel(Result.self)
            .catchErrorJustReturn(Result())
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .default))
            .observeOn(MainScheduler.instance)
    }
    
    func updateProduction(_ request:Production, _ imageRequest: ProductionImageRequest) -> Observable<Result<Production>> {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd_HH-mm-ss_SSS"
        let formDataArray: [Moya.MultipartFormData] = [imageRequest.coverImg?.jpegData(compressionQuality: 0.5)]
            .map{
                let fileName = "\(formatter.string(from: Date())).jpg"
                return MultipartFormData(provider: .data($0 ?? Data()), name: "image", fileName: fileName, mimeType:"image/jpg")
            }
        let param = ["param" : request.toJSONString() ?? ""]
        return moya.rx
            .request(.updateProduction(formDataArray, param))
            .trackActivity(indicator)
            .asObservable()
            .mapModel(Result.self)
            .catchErrorJustReturn(Result())
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .default))
            .observeOn(MainScheduler.instance)
    }
    
    func signup(_ request:User, _ imageRequest: ProductionImageRequest) -> Observable<Result<User>> {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd_HH-mm-ss_SSS"
        let formDataArray: [Moya.MultipartFormData] = [imageRequest.coverImg?.jpegData(compressionQuality: 0.5)]
            .map{
                let fileName = "avatar_\(formatter.string(from: Date())).jpg"
                return MultipartFormData(provider: .data($0 ?? Data()), name: "image", fileName: fileName, mimeType:"image/jpg")
            }
        let param = ["param" : request.toJSONString() ?? ""]
        return moya.rx
            .request(.signup(formDataArray, param))
            .trackActivity(indicator)
            .asObservable()
            .mapModel(Result.self)
            .catchErrorJustReturn(Result())
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .default))
            .observeOn(MainScheduler.instance)
    }
}
