//
//  DataBaseService.swift
//  RxSwiftDemo
//
//  Created by 張帥 on 2018/12/25.
//  Copyright © 2018 張帥. All rights reserved.
//

import Foundation
import FMDB

class DataBaseService {
    static let shared = DataBaseService()
    private init() {
//        var documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last
//        var filePath = URL(fileURLWithPath: documentsPath ?? "").appendingPathComponent("repositories.sqlite").absoluteString
//        db = FMDatabase(path: filePath)
//        db.open()
//        defer {
//            db.close()
//        }
//        
//        var personSql = """
//        CREATE TABLE 'person' (\
//            'id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,\
//            'person_id' VARCHAR(255),\
//            'person_name' VARCHAR(255),\
//            'person_age' VARCHAR(255),\
//            'person_number'VARCHAR(255)\
//            )
//    """
//        var carSql = """
//        CREATE TABLE 'car' (\
//            'id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,\
//            'own_id' VARCHAR(255),\
//            'car_id' VARCHAR(255),\
//            'car_brand' VARCHAR(255),\
//            'car_price'VARCHAR(255)\
//            )
//    """
//        
//        db.executeUpdate(personSql)
//        db.executeUpdate(carSql)
        
        
    }
}
