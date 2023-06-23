//
//  DBHelper.swift
//  StoryboardAssignment
//
//  Created by Bhakti MALKHARE on 21/06/23.
//

import Foundation
import SQLite3
//    struct RegisterDataModel {
//        var name: String
//        var password: String
//        var gender: Gender
//        var birthDate: String
//    }
//class DBHelper
//{
//    init()
//    {
//        db = openDatabase()
//        createTable()
//    }
//
//    let dbPath: String = "myDb.sqlite"
//    var db:OpaquePointer?
//
//    func openDatabase() -> OpaquePointer?
//    {
//        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//            .appendingPathComponent(dbPath)
//        var db: OpaquePointer? = nil
//        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
//        {
//            print("error opening database")
//            return nil
//        }
//        else
//        {
//            print("Successfully opened connection to database at \(dbPath)")
//            return db
//        }
//    }
//
//
//    func createTable() {
//        let createTableString = "CREATE TABLE IF NOT EXISTS person(Id INTEGER PRIMARY KEY,name TEXT,age INTEGER);"
//        var createTableStatement: OpaquePointer? = nil
//        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
//        {
//            if sqlite3_step(createTableStatement) == SQLITE_DONE
//            {
//                print("person table created.")
//            } else {
//                print("person table could not be created.")
//            }
//        } else {
//            print("CREATE TABLE statement could not be prepared.")
//        }
//        sqlite3_finalize(createTableStatement)
//    }
//
//
//    func insert(id:Int, name:String, age:Int)
//    {
//        let persons = read()
//        for p in persons
//        {
//            if p.id == id
//            {
//                return
//            }
//        }
//        let insertStatementString = "INSERT INTO person (Id, name, age) VALUES (?, ?, ?);"
//        var insertStatement: OpaquePointer? = nil
//        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
//            sqlite3_bind_int(insertStatement, 1, Int32(id))
//            sqlite3_bind_text(insertStatement, 2, (name as NSString).utf8String, -1, nil)
//            sqlite3_bind_int(insertStatement, 3, Int32(age))
//
//            if sqlite3_step(insertStatement) == SQLITE_DONE {
//                print("Successfully inserted row.")
//            } else {
//                print("Could not insert row.")
//            }
//        } else {
//            print("INSERT statement could not be prepared.")
//        }
//        sqlite3_finalize(insertStatement)
//    }
//
//    func read() -> [Person] {
//        let queryStatementString = "SELECT * FROM person;"
//        var queryStatement: OpaquePointer? = nil
//        var psns : [Person] = []
//        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
//            while sqlite3_step(queryStatement) == SQLITE_ROW {
//                let id = sqlite3_column_int(queryStatement, 0)
//                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
//                let year = sqlite3_column_int(queryStatement, 2)
//                psns.append(Person(id: Int(id), name: name, age: Int(year)))
//                print("Query Result:")
//                print("\(id) | \(name) | \(year)")
//            }
//        } else {
//            print("SELECT statement could not be prepared")
//        }
//        sqlite3_finalize(queryStatement)
//        return psns
//    }
//
//    func deleteByID(id:Int) {
//        let deleteStatementStirng = "DELETE FROM person WHERE Id = ?;"
//        var deleteStatement: OpaquePointer? = nil
//        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
//            sqlite3_bind_int(deleteStatement, 1, Int32(id))
//            if sqlite3_step(deleteStatement) == SQLITE_DONE {
//                print("Successfully deleted row.")
//            } else {
//                print("Could not delete row.")
//            }
//        } else {
//            print("DELETE statement could not be prepared")
//        }
//        sqlite3_finalize(deleteStatement)
//    }
//
//}
//class Person
//{
//
//    var name: String = ""
//    var age: Int = 0
//    var id: Int = 0
//
//    init(id:Int, name:String, age:Int)
//    {
//        self.id = id
//        self.name = name
//        self.age = age
//    }
//
//}
class DBHelper
{
    init()
    {
        db = openDatabase()
        createTable()
    }

    let dbPath: String = "myDb.sqlite"
    var db:OpaquePointer?

    func openDatabase() -> OpaquePointer?
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
  
    
    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS person(name TEXT PRIMARY KEY,password TEXT,gender TEXT,birthDate Text,category Text);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("person table created.")
            } else {
                print("person table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
  
    func isUserAlreadyExist(name:String) -> Bool {
        let persons = read()
        for p in persons
        {
            if p.name == name
            {
                return true
            }
        }
        return false
    }
    
    func insert(name:String, password:String, gender:String, birthDate: String,category: String = "None")
    {
       
        let insertStatementString = "INSERT INTO person (name, password, gender, birthDate, category) VALUES (?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (password as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (gender as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (birthDate as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (category as NSString).utf8String, -1, nil)

            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func read() -> [Person] {
        let queryStatementString = "SELECT * FROM person;"
        var queryStatement: OpaquePointer? = nil
        var psns : [Person] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
                let password = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let gender = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let birthDate = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                var categoryListJson  = ""
                if sqlite3_column_text(queryStatement, 4) != nil {
                categoryListJson = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                }
                psns.append(Person(name: name, password: password, gender: gender, birthDate: birthDate, categoryListJson: categoryListJson))
                print("Query Result:")
                print("\(name) | \(password) | \(gender) | \(birthDate)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return psns
    }
    

    func update(person: Person, categoryJSON: String) {
        let query = "UPDATE person SET category = '\(categoryJSON)' WHERE name = '\(person.name)';"
            var statement : OpaquePointer? = nil
            if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK{
                if sqlite3_step(statement) == SQLITE_DONE {
                    print("Data updated success")
                }else {
                    print("Data is not updated in table")
                }
            }
        }
}


class Person
{
    var name: String = ""
    var password: String = ""
    var gender: String = ""
    var birthDate: String = ""
    var confirmPassword: String = ""
    var categoryListJson: String = ""

    init(name: String, password: String, gender:String, birthDate: String, categoryListJson: String = "")
    {
        self.name = name
        self.password = password
        self.gender = gender
        self.birthDate = birthDate
        self.categoryListJson = categoryListJson
    }
    
}
