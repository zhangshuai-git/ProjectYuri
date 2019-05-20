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

class Result<T: HandyJSON>: HandyJSON {
    var code: Int = 999
    var message: String = "无法连接到服务器"
    var data: T = T()
    
    required init() { }
}

class PageResult<T>: HandyJSON {
    var totalCount: Int64 = 0
    var totalPage: Int = 0
    var currentPage: Int = 0
    var items: [T] = []
    
    static func + (obj0: PageResult, obj1: PageResult) -> PageResult {
        let obj = PageResult()
        obj.totalCount = max(obj0.totalCount, obj1.totalCount)
        obj.items = obj0.items + obj1.items
        obj.currentPage = max(obj0.currentPage, obj1.currentPage)
        return obj
    }
    
    required init() { }
}

class Production: HandyJSON {
    var id: Int64 = 0
    var name: String = ""
    var nameCN: String = ""
    var desp: String = ""
    var info: String = ""
    var coverUrl: String = ""
    var category: ProductionCategory?
    var charactersList: [Characters] = []
    var commentList: [Comment] = []
    
    required init(){}
}

class Characters: HandyJSON {
    var avatarUrl: String = ""
    var name: String = ""
    var cv: String = ""
    
    required init(){}
}

class Comment: HandyJSON {
    var content: String = ""
    var author: User = User()
    var date: Date = Date()
    
    required init(){}
}

class User: HandyJSON {
    var name: String = ""
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

enum Schedule: Int, CaseIterable, HandyJSONEnum {
    case todo
    case doing
    case done
}

enum Evaluation: Int, CaseIterable, HandyJSONEnum {
    case like
    case criticism
}

public enum ProductionCategory: String, CaseIterable, HandyJSONEnum {
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

