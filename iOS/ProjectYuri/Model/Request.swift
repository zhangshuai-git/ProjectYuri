//
//  RequestParams.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/04/04.
//  Copyright © 2019 張帥. All rights reserved.
//

import HandyJSON
import RxSwift
import RxCocoa

class AddProductionRequest: HandyJSON {
    var name: String = ""
    var nameCN: String = ""
    var desp: String = ""
    var category: ProductionCategory?
    
    required init() { }
}

class AddProductionImageRequest {
    var coverImg: UIImage?
}

class ProductionRequest: HandyJSON {
    var page:Int = 0
    var size:Int = 10
    
    init(page:Int = 1) {
        self.page = page
    }
    
    required init() { }
}

class RepositoriesRequest: HandyJSON {
    var query:String = ""
    var sort:String = "stars"
    var order:String = "desc"
    var perPage:UInt = PER_PAGE
    var page:Int = 1

    func mapping(mapper: HelpingMapper) {
        mapper <<< query <-- "q"
        mapper <<< perPage <-- "per_page"
    }

    init(query:String = "", page:Int = 1) {
        self.query = query
        self.page = page
    }

    required init() { }
}
