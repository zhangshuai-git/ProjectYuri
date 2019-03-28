//
//  DataBaseAPI.swift
//  ProjectYuri
//
//  Created by 張帥 on 2018/12/25.
//  Copyright © 2018 張帥. All rights reserved.
//

import Foundation
import FMDB

class DatabaseAPI {
    static let shared = DatabaseAPI()
    private init() {
        createTable()
    }
    
    let db: FMDatabase = {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last ?? ""
        let filePath = URL(fileURLWithPath: documentsPath).appendingPathComponent("repositories.sqlite").absoluteString
        print("[database init] \(filePath)")
        return FMDatabase(path: filePath)
    }()
    
    func createTable() {
        execute {
            print("create table")
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
    }
    
    func add(repository : Repository) {
        execute {
            print("add \(repository.name)", tag: "DataBaseDebug")
            db.executeUpdate("INSERT INTO repository(id, own_id, name, full_name, html_url, description, comment)VALUES(?,?,?,?,?,?,?)", withArgumentsIn: [repository.id, repository.owner.id, repository.name, repository.fullName, repository.htmlUrl, repository.desp, repository.comment])
            db.executeUpdate("INSERT INTO repository_owner(id, login, url, avatar_url)VALUES(?,?,?,?)", withArgumentsIn: [repository.owner.id, repository.owner.login, repository.owner.url, repository.owner.avatarUrl])
        }
    }
    
    func delete(repository: Repository) {
        execute {
            print("delete \(repository.name)", tag: "DataBaseDebug")
            db.executeUpdate("DELETE FROM repository WHERE id = ?", withArgumentsIn: [repository.id])
        }
    }
    
    func update(repository: Repository) {
        execute {
            print("update \(repository.name)", tag: "DataBaseDebug")
            db.executeUpdate("UPDATE 'repository' SET name = ?  WHERE id = ? ", withArgumentsIn: [repository.name, repository.id])
            db.executeUpdate("UPDATE 'repository' SET full_name = ?  WHERE id = ? ", withArgumentsIn: [repository.fullName, repository.id])
            db.executeUpdate("UPDATE 'repository' SET html_url = ?  WHERE id = ? ", withArgumentsIn: [repository.htmlUrl, repository.id])
            db.executeUpdate("UPDATE 'repository' SET description = ?  WHERE id = ? ", withArgumentsIn: [repository.desp,   repository.id])
            db.executeUpdate("UPDATE 'repository' SET comment = ?  WHERE id = ? ", withArgumentsIn: [repository.comment, repository.id])
        }
    }
    
    func getAllRepository() -> [Repository] {
        var dataArray: [Repository] = []
        execute {
            print("getAllRepository", tag: "DataBaseDebug")
            let res: FMResultSet = db.executeQuery("SELECT * FROM repository ", withArgumentsIn: []) ?? FMResultSet()
            while res.next() {
                let repository = Repository()
                repository.id = Int(res.int(forColumn: "id"))
                repository.owner.id = Int(res.int(forColumn: "own_id"))
                repository.name = res.string(forColumn: "name") ?? ""
                repository.fullName = res.string(forColumn: "full_name") ?? ""
                repository.htmlUrl = res.string(forColumn: "html_url") ?? ""
                repository.desp = res.string(forColumn: "description") ?? ""
                repository.comment = res.string(forColumn: "comment") ?? ""
                repository.owner = getRepositoryOwner(id: repository.owner.id)
                dataArray.append(repository)
            }
        }
        return dataArray
    }
    
    func getRepository(id: Int) -> Repository {
        let repository = Repository()
        execute {
            print("getRepository \(id)", tag: "DataBaseDebug")
            let res: FMResultSet = db.executeQuery("SELECT * FROM repository where id = ? ", withArgumentsIn: [id]) ?? FMResultSet()
            while res.next() {
                repository.id = Int(res.int(forColumn: "id"))
                repository.owner.id = Int(res.int(forColumn: "own_id"))
                repository.name = res.string(forColumn: "name") ?? ""
                repository.fullName = res.string(forColumn: "full_name") ?? ""
                repository.htmlUrl = res.string(forColumn: "html_url") ?? ""
                repository.desp = res.string(forColumn: "description") ?? ""
                repository.comment = res.string(forColumn: "comment") ?? ""
                repository.owner = getRepositoryOwner(id: repository.owner.id)
            }
        }
        return repository
    }
    
    func getRepositoryOwner(id: Int) -> RepositoryOwner {
        let owner = RepositoryOwner()
        execute {
            print("getRepositoryOwner \(id)", tag: "DataBaseDebug")
            let res: FMResultSet = db.executeQuery("SELECT * FROM repository_owner where id = ? ", withArgumentsIn: [id]) ?? FMResultSet()
            while res.next() {
                owner.id = Int(res.int(forColumn: "id"))
                owner.login = res.string(forColumn: "login") ?? ""
                owner.url = res.string(forColumn: "url") ?? ""
                owner.avatarUrl = res.string(forColumn: "avatar_url") ?? ""
            }
        }
        return owner
    }
    
    func execute(_ cmd: () -> Void) {
        var isOpen = false
        if !db.isOpen {
            isOpen = db.open()
            print("open db")
        }
        defer {
            if isOpen {
                db.close()
                print("close db")
            }
        }
        cmd()
    }
    
}
