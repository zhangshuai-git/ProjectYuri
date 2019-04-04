//
//  Entity.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/04/04.
//  Copyright © 2019 張帥. All rights reserved.
//

import HandyJSON
import RxSwift
import RxCocoa

class Repositories: HandyJSON {
    var totalCount:UInt = 0
    var items: [Repository] = []
    
    var currentPage:Int = 1
    var totalPage:UInt {
        return totalCount / PER_PAGE
    }
    
    public func mapping(mapper: HelpingMapper) {
        mapper <<< totalCount <-- "total_count"
    }
    
    static func + (obj0: Repositories, obj1: Repositories) -> Repositories {
        let obj = Repositories()
        obj.totalCount = max(obj0.totalCount, obj1.totalCount)
        obj.items = obj0.items + obj1.items
        obj.currentPage = max(obj0.currentPage, obj1.currentPage)
        return obj
    }
    
    required init() { }
}

class Repository: HandyJSON {
    var id: Int = 0
    var name: String = ""
    var fullName: String = ""
    var desp: String = ""
    var htmlUrl: String = ""
    var owner: RepositoryOwner = RepositoryOwner()
    
    var comment: String = ""
    var isSubscribed:Bool = false
    var isExpanded:Bool = false
    var category: ProductionCategory? = ProductionCategory.allCases.randomElement()
    
    public func mapping(mapper: HelpingMapper) {
        mapper <<< fullName <-- "full_name"
        mapper <<< htmlUrl <-- "html_url"
        mapper <<< desp <-- "description"
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
