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

class ProductionImageRequest {
    var coverImg: UIImage?
}

class ProductionRequest: HandyJSON {
    var query:String = ""
    var page:Int = 0
    var size:Int = 10
    
    init(query:String = "", page:Int = 0) {
        self.query = query
        self.page = page
    }
    
    required init() { }
}

