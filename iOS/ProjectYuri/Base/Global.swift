//
//  Global.swift
//  SwiftDemo
//
//  Created by 張帥 on 2018/11/30.
//  Copyright © 2018 張帥. All rights reserved.
//

import Foundation

func print<T>(_ message: T, tag: String? = nil, filePath: String = #file, methodName: String = #function, lineNumber: Int = #line) {
    #if DEBUG
    let formatter = DateFormatter()
    formatter.dateFormat = "yyMMdd-HHmmss"
    let date = formatter.string(from: Date())
    let fileName = (filePath as NSString).lastPathComponent
    Swift.print("\(tag ?? date) <\(fileName)> \(methodName) [Line \(lineNumber)] \(message)")
    #endif
}

let MAIN_COLOR = "#afedc5"
let TABBAR_NORMAL_COLOR = "#626065"


