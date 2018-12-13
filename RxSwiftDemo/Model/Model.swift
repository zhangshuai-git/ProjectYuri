//
//  HomeModel.swift
//  RxSwiftDemo
//
//  Created by 張帥 on 2018/12/11.
//  Copyright © 2018 張帥. All rights reserved.
//

import Foundation

class HomeModel: HandyJSON {
    
    var number: Int = 0
    var description: String = ""
    
    required init() { }
}

//包含查询返回的所有库模型
class GitHubRepositories: HandyJSON {
    var totalCount: Int!
    var incompleteResults: Bool!
    var items: [GitHubRepository]! //本次查询返回的所有仓库集合
    
    required init() {
        print("init()")
        totalCount = 0
        incompleteResults = false
        items = []
    }
    
}

//单个仓库模型
class GitHubRepository: HandyJSON {
    var id: Int!
    var name: String!
    var full_name: String!
    var html_url: String!
    var description: String!
    var owner: RepositoryOwner!
    
    required init() { }
}


class RepositoryOwner: HandyJSON {
    var id: Int!
    var login: String!
    var url: String!
    var avatar_url: String!
    
    required init() { }
}
