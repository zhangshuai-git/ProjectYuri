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
        print("[database init] \(filePath)")
        return FMDatabase(path: filePath)
    }()
    
    func createTable() {
        db.open()
        defer {
            db.close()
        }
        
        db.executeStatements("""
        CREATE TABLE IF NOT EXISTS 'repository' (\
            'id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,\
            'own_id' INT,\
            'name' VARCHAR(255),\
            'full_name' VARCHAR(255),\
            'html_url' VARCHAR(255),\
            'description' VARCHAR(255),\
            'comment' VARCHAR(255)\
            )
        """)
        
        db.executeStatements("""
        CREATE TABLE IF NOT EXISTS 'repository_owner' (\
            'id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,\
            'login' VARCHAR(255),\
            'url' VARCHAR(255),\
            'avatar_url' VARCHAR(255)\
            )
        """)
    }
    
    func add(repository : Repository) -> Void {
        db.open()
        defer {
            db.close()
        }
        
        db.executeUpdate("INSERT INTO repository(id, own_id, name, full_name, html_url, description, comment)VALUES(?,?,?,?,?,?,?)", withArgumentsIn: [repository.id, repository.owner.id, repository.name, repository.fullName, repository.htmlUrl, repository.desp, repository.comment])
        
        db.executeUpdate("INSERT INTO repository_owner(id, login, url, avatar_url)VALUES(?,?,?,?)", withArgumentsIn: [repository.owner.id, repository.owner.login, repository.owner.url, repository.owner.avatarUrl])
    }
    
    func delete(repository: Repository) {
        db.open()
        defer {
            db.close()
        }
        
        db.executeUpdate("DELETE FROM repository WHERE id = ?", withArgumentsIn: [repository.id])
//        db.executeUpdate("DELETE FROM repository_owner WHERE id = ?", withArgumentsIn: [repository.owner.id])
//        let ownerRes: FMResultSet = db.executeQuery("SELECT * FROM repository_owner where id = ? ", withArgumentsIn: [repository.owner.id]) ?? FMResultSet()
//        
//        while ownerRes.next() {
//            let owner = RepositoryOwner()
//            owner.id = Int(res.int(forColumn: "id"))
//            owner.login = res.string(forColumn: "login") ?? ""
//            owner.url = res.string(forColumn: "url") ?? ""
//            owner.avatarUrl = res.string(forColumn: "avatar_url") ?? ""
//            
//            repository.owner = owner
//        }
    }

    func update(repository: Repository) {
        db.open()
        defer {
            db.close()
        }
        
        db.executeUpdate("UPDATE 'repository' SET name = ?  WHERE id = ? ", withArgumentsIn: [repository.name, repository.id])
        db.executeUpdate("UPDATE 'repository' SET full_name = ?  WHERE id = ? ", withArgumentsIn: [repository.fullName, repository.id])
        db.executeUpdate("UPDATE 'repository' SET html_url = ?  WHERE id = ? ", withArgumentsIn: [repository.htmlUrl, repository.id])
        db.executeUpdate("UPDATE 'repository' SET description = ?  WHERE id = ? ", withArgumentsIn: [repository.desp,   repository.id])
        db.executeUpdate("UPDATE 'repository' SET comment = ?  WHERE id = ? ", withArgumentsIn: [repository.comment, repository.id])
    }
    
    func getAllRepository() -> [Repository] {
        db.open()
        defer {
            db.close()
        }
        
        var dataArray: [Repository] = []
        
        let res: FMResultSet = db.executeQuery("SELECT * FROM repository", withArgumentsIn: []) ?? FMResultSet()
        
        while res.next() {
            let repository = Repository()
            repository.id = Int(res.int(forColumn: "id"))
            repository.name = res.string(forColumn: "name") ?? ""
            repository.fullName = res.string(forColumn: "full_name") ?? ""
            repository.htmlUrl = res.string(forColumn: "html_url") ?? ""
            repository.desp = res.string(forColumn: "description") ?? ""
            repository.comment = res.string(forColumn: "comment") ?? ""
            
            let ownerRes: FMResultSet = db.executeQuery("SELECT * FROM repository_owner where id = ? ", withArgumentsIn: [repository.owner.id]) ?? FMResultSet()
            
            while ownerRes.next() {
                let owner = RepositoryOwner()
                owner.id = Int(ownerRes.int(forColumn: "id"))
                owner.login = ownerRes.string(forColumn: "login") ?? ""
                owner.url = ownerRes.string(forColumn: "url") ?? ""
                owner.avatarUrl = ownerRes.string(forColumn: "avatar_url") ?? ""
                
                repository.owner = owner
            }
            
            dataArray.append(repository)
        }
        
        return dataArray
    }
}
