//
//  NetworkAPI.swift
//  RxSwiftDemo
//
//  Created by 張帥 on 2018/12/13.
//  Copyright © 2018 張帥. All rights reserved.
//

import Foundation

let GitHubProvider = MoyaProvider<GitHubAPI>()

public enum GitHubAPI {
    /**
     GET /search/repositories
     
     q      string     Required. The search keywords, as well as any qualifiers.
     sort   string     The sort field. One of stars, forks, or updated. Default: results are sorted by best match.
     order  string     The sort order if sort parameter is provided. One of asc or desc. Default: desc
     */
    case repositories(String)
}

extension GitHubAPI: TargetType {
    public var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    public var path: String {
        switch self {
        case .repositories:
            return "/search/repositories"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .repositories:
            return .get
        }
    }
    
    public var task: Task {
        print("发起请求。")
        switch self {
        case .repositories(let query):
            var params: [String: Any] = [:]
            params["q"] = query
            params["sort"] = "stars"
            params["order"] = "desc"
            params["per_page"] = "10"
            params["page"] = "1"
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
