//
//  String+ZSExtension.swift
//  ProjectYuri
//
//  Created by 張帥 on 2019/04/02.
//  Copyright © 2019 張帥. All rights reserved.
//

import Foundation

extension String {
    static let random_str_characters = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    static func random(len : Int) -> String {
        var ranStr = ""
        for _ in 0..<len {
            let index = Int(arc4random_uniform(UInt32(random_str_characters.count)))
            ranStr.append(random_str_characters[random_str_characters.index(random_str_characters.startIndex, offsetBy: index)])
        }
        return ranStr
    }
}
