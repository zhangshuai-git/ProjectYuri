//
//  NetworkAPI.swift
//  ProjectYuri
//
//  Created by 張帥 on 2018/12/13.
//  Copyright © 2018 張帥. All rights reserved.
//

import Foundation
import Moya

let ProjectYuriProvider = MoyaProvider<ProjectYuriAPI>()

public enum ProjectYuriAPI {
    case findAllProductions([String : Any])
    case addProduction([MultipartFormData], [String: Any])
    case updateProduction([MultipartFormData], [String: Any])
}

extension ProjectYuriAPI: TargetType {
    
    public var baseURL: URL {
        return URL(string: "http://localhost:8070")!
    }
    
    public var path: String {
        switch self {
        case .findAllProductions(_):
            return "/api/v1/production"
        case .addProduction(_, _):
            return "/api/v1/production"
        case .updateProduction(_, _):
            return "/api/v1/production"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .findAllProductions(_):
            return .get
        case .addProduction(_, _):
            return .post
        case .updateProduction(_, _):
            return .put
        }
    }
    
    public var task: Task {
        switch self {
        case .findAllProductions(let params):
            print("发起请求: \(params)")
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .addProduction(let formData, let params):
            print("发起请求: \(formData) \(params)")
            return .uploadCompositeMultipart(formData, urlParameters: params)
        case .updateProduction(let formData, let params):
            print("发起请求: \(formData) \(params)")
            return .uploadCompositeMultipart(formData, urlParameters: params)
        }
    }
    
    public var headers: [String: String]? {
        return nil
    }
    
    public var validate: Bool {
        return false
    }
    
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
}
