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
    case addProduction([MultipartFormData], [String: Any])
    case findAllProductions([String : Any])
}

extension ProjectYuriAPI: TargetType {
    
    public var baseURL: URL {
        return URL(string: "http://localhost:8070")!
    }
    
    public var path: String {
        switch self {
        case .addProduction:
            return "/api/v1/production"
        case .findAllProductions:
            return "/api/v1/production"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .addProduction:
            return .post
        case .findAllProductions:
            return .get
        }
    }
    
    public var task: Task {
        switch self {
        case .addProduction(let formData, let params):
            print("发起请求: \(formData) \(params)")
            return .uploadCompositeMultipart(formData, urlParameters: params)
        case .findAllProductions(let params):
            print("发起请求: \(params)")
             return .requestParameters(parameters: params, encoding: URLEncoding.default)
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
