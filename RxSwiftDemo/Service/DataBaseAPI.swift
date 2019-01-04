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
        
        //        class Repository: HandyJSON {
        //            var id: Int = 0
        //            var name: String = ""
        //            var fullName: String = ""
        //            var htmlUrl: String = ""
        //            var description: String = ""
        //            var owner: RepositoryOwner = RepositoryOwner()
        //
        //        }
        db.executeStatements("""
        CREATE TABLE 'repository' (\
            'id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,\
            'repository_id' INT,\
            'name' INT,\
            'full_name' VARCHAR(255),\
            'html_url' VARCHAR(255),\
            'description' VARCHAR(255),\
            'comment' VARCHAR(255),\
            'owner' VARCHAR(255)\
            )
        """)
        
        //        class RepositoryOwner: HandyJSON {
        //            var id: Int = 0
        //            var login: String = ""
        //            var url: String = ""
        //            var avatarUrl: String = ""
        //
        //        }
        db.executeStatements("""
        CREATE TABLE 'repository_owner' (\
            'id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,\
            'repository_id' INT,\
            'owner_id' INT,\
            'login' VARCHAR(255),\
            'url' VARCHAR(255),\
            'avatarUrl' VARCHAR(255)\
            )
        """)
    }
}
