//
//  Global.swift
//  SwiftDemo
//
//  Created by 張帥 on 2018/11/30.
//  Copyright © 2018 張帥. All rights reserved.
//

import Foundation

//let MAIN_COLOR = "#cd85d3"
let MAIN_COLOR = "#004833"

func print<T>(_ message: T, tag: String? = nil, filePath: String = #file, methodName: String = #function, lineNumber: Int = #line) {
    #if DEBUG
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    let date = formatter.string(from: Date())
    let fileName = (filePath as NSString).lastPathComponent
    Swift.print("\(tag ?? date) <\(fileName)> \(methodName) [Line \(lineNumber)] \(message)")
    #endif
}


