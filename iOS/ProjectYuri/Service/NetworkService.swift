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
    
    func addProduction(_ request:AddProductionRequest, _ imageRequest: AddProductionImageRequest) -> Observable<Result<Production>> {
        var formDataArray = [MultipartFormData]()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd_HH:mm:ss.SSS"
        for data in [imageRequest.coverImg?.jpegData(compressionQuality: 0.5)] {
            let fileName = "\(formatter.string(from: Date())).jpg"
            formDataArray.append(MultipartFormData(provider: .data(data ?? Data()), name: "image", fileName: fileName, mimeType:"image/jpg"))
        }
        return ProjectYuriProvider.rx
            .request(.addProduction(formDataArray, urlParameters: request.toJSON() ?? [:]))
            .trackActivity(indicator)
            .asObservable()
            .mapModel(Result.self)
            .catchErrorJustReturn(Result())
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .default))
            .observeOn(MainScheduler.instance)
    }
    
    func searchRepositories(_ request:RepositoriesRequest) -> Observable<Repositories> {
        return GitHubProvider.rx
            .request(.repositories(request.toJSON() ?? [:]))
            .trackActivity(indicator)
            .asObservable()
            .mapModel(Repositories.self)
            .catchErrorJustReturn(Repositories())
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .default))
            .observeOn(MainScheduler.instance)
    }
}
