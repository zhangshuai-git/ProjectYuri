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

extension Optional where Wrapped == String {
    @inline(__always) func isNilOrEmpty() -> Bool {
        return self == nil || self!.isEmpty
    }
    
    @inline(__always) func orEmpty() -> String {
        return self ?? ""
    }
}
extension String {
    @inline(__always) func isNotEmpty() -> Bool {
        return self != ""
    }
}

extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }

    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }

    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }

    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
}
