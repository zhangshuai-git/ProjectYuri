//
//  HomeModel.swift
//  RxSwiftDemo
//
//  Created by 張帥 on 2018/12/11.
//  Copyright © 2018 張帥. All rights reserved.
//

import Foundation

//class HomeModel: HandyJSON {
//    
//    var number: Int = 0
//    var description: String = ""
//    
//    required init() { }
//}



class GitHubRepositories: HandyJSON {
    var total_count: Int = 0
    var items: [GitHubRepository] = []
    
    required init() { }
    
    static func + (obj0: GitHubRepositories, obj1: GitHubRepositories) -> GitHubRepositories {
        let obj = GitHubRepositories()
        obj.total_count = max(obj0.total_count, obj1.total_count)
        obj.items = obj0.items + obj1.items
        return obj
    }
}

class GitHubRepository: HandyJSON {
    var id: Int = 0
    var name: String = ""
    var full_name: String = ""
    var html_url: String = ""
    var description: String = ""
    var owner: RepositoryOwner = RepositoryOwner()
    
    required init() { }
}

class RepositoryOwner: HandyJSON {
    var id: Int = 0
    var login: String = ""
    var url: String = ""
    var avatar_url: String = ""
    
    required init() { }
}
