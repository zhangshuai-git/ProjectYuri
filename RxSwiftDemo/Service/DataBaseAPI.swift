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
    
    func add(repository : Repository) -> Void {
        db.open()
        defer {
            db.close()
        }
        
        var maxID = 0
        
        let res: FMResultSet = (try? db.executeQuery("SELECT * FROM repository ", values: nil)) ?? FMResultSet()
        //获取数据库中最大的ID
        while res.next() {
            if maxID < res.int(forColumn: "repository_id") {
                maxID = Int(res.int(forColumn: "repository_id") )
            }
        }
        maxID = maxID + 1
        
        try? db.executeUpdate("INSERT INTO repository(repository_id,name,full_name,html_url,description, comment)VALUES(?,?,?,?,?,?)", values: [maxID, repository.name, repository.fullName, repository.htmlUrl, repository.description, repository.comment])
    }
    
    func delete(repository: Repository) {
        db.open()
        defer {
            db.close()
        }
        
        try? db.executeUpdate("DELETE FROM person WHERE person_id = ?", values: [repository.id])
    }

    func update(repository: Repository) {
        db.open()
        defer {
            db.close()
        }
        
        try? db.executeUpdate("UPDATE 'person' SET name = ?  WHERE person_id = ? ", values: [repository.name, repository.id])
        try? db.executeUpdate("UPDATE 'person' SET full_name = ?  WHERE person_id = ? ", values: [repository.fullName, repository.id])
        try? db.executeUpdate("UPDATE 'person' SET html_url = ?  WHERE person_id = ? ", values: [repository.htmlUrl, repository.id])
        try? db.executeUpdate("UPDATE 'person' SET description = ?  WHERE person_id = ? ", values: [repository.description,   repository.id])
        try? db.executeUpdate("UPDATE 'person' SET comment = ?  WHERE person_id = ? ", values: [repository.comment, repository.id])
    }
    
    func getAllRepository() -> [Repository] {
        db.open()
        defer {
            db.close()
        }
        
        var dataArray: [Repository] = []
        
        let res: FMResultSet = (try? db.executeQuery("SELECT * FROM person", values: nil)) ?? FMResultSet()
        
        while res.next() {
            let repository = Repository()
            repository.id = Int(res.int(forColumn: "person_id"))
            repository.name = res.string(forColumn: "name") ?? ""
            repository.fullName = res.string(forColumn: "full_name") ?? ""
            repository.htmlUrl = res.string(forColumn: "html_url") ?? ""
            repository.description = res.string(forColumn: "description") ?? ""
            repository.comment = res.string(forColumn: "comment") ?? ""
            dataArray.append(repository)
        }
        
        return dataArray
    }
}
