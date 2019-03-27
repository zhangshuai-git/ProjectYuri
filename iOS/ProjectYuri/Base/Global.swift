//
//  Global.swift
//  SwiftDemo
//
//  Created by 張帥 on 2018/11/30.
//  Copyright © 2018 張帥. All rights reserved.
//

import Foundation

let MAIN_COLOR = "#e18996"
//let MAIN_COLOR = "#383838"
//let MAIN_COLOR = "#004833"
let SCREEN_MAX_LENGTH = max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
let SCREEN_MIN_LENGTH = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)

func print<T>(_ message: T, tag: String? = nil, filePath: String = #file, methodName: String = #function, lineNumber: Int = #line) {
    #if DEBUG
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    let date = formatter.string(from: Date())
    let fileName = (filePath as NSString).lastPathComponent
    Swift.print("\(tag ?? date) <\(fileName)> \(methodName) [Line \(lineNumber)] \(message)")
    #endif
}


