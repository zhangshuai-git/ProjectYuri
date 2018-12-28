//
//  DataBaseAPI.swift
//  RxSwiftDemo
//
//  Created by 張帥 on 2018/12/25.
//  Copyright © 2018 張帥. All rights reserved.
//

import Foundation
import FMDB

class DataBaseAPI {
    static let shared = DataBaseAPI()
    private init() {
        createTable()
    }
    
    lazy var db: FMDatabase = {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last ?? ""
        let filePath = URL(fileURLWithPath: documentsPath).appendingPathComponent("repositories.sqlite").absoluteString
        return FMDatabase(path: filePath)
    }()
    
    func createTable() {
        db.open()
        defer {
            db.close()
        }
        
        let personSql = """
        CREATE TABLE 'person' (\
            'id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,\
            'person_id' VARCHAR(255),\
            'person_name' VARCHAR(255),\
            'person_age' VARCHAR(255),\
            'person_number'VARCHAR(255)\
            )
        """
        let carSql = """
        CREATE TABLE 'car' (\
            'id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,\
            'own_id' VARCHAR(255),\
            'car_id' VARCHAR(255),\
            'car_brand' VARCHAR(255),\
            'car_price'VARCHAR(255)\
            )
        """
        db.executeStatements(personSql)
        db.executeStatements(carSql)
    }
}
