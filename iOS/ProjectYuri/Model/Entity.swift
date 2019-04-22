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

class Result<T>: HandyJSON {
    var code: Int?
    var message: String?
    var data: T?
    
    required init() { }
}

class Production: HandyJSON {
    var name = ""
    var nameCN = ""
    var desp: String = ""
    var info: String = ""
    var coverUrl: String = ""
    var category: ProductionCategory?
    var producerList: [Producer] = []
    var characterList: [Character] = []
    var commentList: [Comment] = []
    
    required init(){}
}

class Producer: HandyJSON {
    var avatarUrl: String = ""
    var name: String = ""
    var role: String = ""
    
    required init(){}
}

class Character: HandyJSON {
    var avatarUrl: String = ""
    var name: String = ""
    var cv: Producer?
    
    required init(){}
}

class Comment: HandyJSON {
    var content: String = ""
    var author: User = User()
    var date: Date = Date()
    
    required init(){}
}

class User: HandyJSON {
    var name = ""
    var avatarUrl: String = ""
    var productionList: [UserProduction] = []
    
    required init(){}
}

class UserProduction: HandyJSON {
    var production: Production?
    var evaluation: Evaluation?
    var schedule: Schedule?
    
    required init(){}
}

enum Schedule: Int, CaseIterable {
    case todo
    case doing
    case done
}

enum Evaluation: Int, CaseIterable {
    case like
    case criticism
}

public enum ProductionCategory: String, CaseIterable {
    case game = "GAME"
    case anime = "ANIME"
    case comic = "COMIC"
    case novel = "NOVEL"
    
    var displayValue: String {
        switch self {
        case .game:
            return "游戏"
        case .anime:
            return "动画"
        case .comic:
            return "漫画"
        case .novel:
            return "小说"
        }
    }
}


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
    
    required init(){}
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
    
    required init(){}
}

class RepositoryOwner: HandyJSON {
    var id: Int = 0
    var login: String = ""
    var url: String = ""
    var avatarUrl: String = ""
    
    public func mapping(mapper: HelpingMapper) {
        mapper <<< avatarUrl <-- "avatar_url"
    }
    
    required init(){}
}

