//
//  HomeModel.swift
//  RxSwiftDemo
//
//  Created by 張帥 on 2018/12/11.
//  Copyright © 2018 張帥. All rights reserved.
//

import Foundation

class RepositoriesParams:HandyJSON {
    var query:String = ""
    var sort:String = "stars"
    var order:String = "desc"
    var perPage:UInt = PER_PAGE
    var page:Int = 1
    
    func mapping(mapper: HelpingMapper) {
        mapper <<< query <-- "q"
        mapper <<< perPage <-- "per_page"
    }
    
    required init() { }
    
    init(query:String = "", page:Int = 1) {
        self.query = query
        self.page = page
    }
}

class GitHubRepositories: HandyJSON {
    var totalCount:UInt = 0
    var items: [GitHubRepository] = []
    var currentPage:Int = 1
    var totalPage:UInt {
        return totalCount / PER_PAGE
    }
    
    public func mapping(mapper: HelpingMapper) {
        mapper <<< totalCount <-- "total_count"
    }
    
    static func + (obj0: GitHubRepositories, obj1: GitHubRepositories) -> GitHubRepositories {
        let obj = GitHubRepositories()
        obj.totalCount = max(obj0.totalCount, obj1.totalCount)
        obj.items = obj0.items + obj1.items
        obj.currentPage = max(obj0.currentPage, obj1.currentPage)
        return obj
    }
    
    required init() { }
}

class GitHubRepository: HandyJSON {
    var id: Int = 0
    var name: String = ""
    var fullName: String = ""
    var htmlUrl: String = ""
    var description: String = ""
    var owner: RepositoryOwner = RepositoryOwner()
    
    public func mapping(mapper: HelpingMapper) {
        mapper <<< fullName <-- "full_name"
        mapper <<< htmlUrl <-- "html_url"
    }
    
    required init() { }
}

class RepositoryOwner: HandyJSON {
    var id: Int = 0
    var login: String = ""
    var url: String = ""
    var avatarUrl: String = ""
    
    public func mapping(mapper: HelpingMapper) {
        mapper <<< avatarUrl <-- "avatar_url"
    }
    
    required init() { }
}
