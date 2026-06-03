//
//  DBManager.swift
//  SQLite
//
//  Created by Metalien on 2026/6/3.
//



import Foundation
import FMDB

class DBManager {
    
    // 数据库目录（Document 永久保存）
    private static var dbDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
//    private static var dbDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first?.appending("/DB")
    
    static var defaultDBName = "FMDB"
    
    // 初始化数据库
    static func createDB(_ fileName: String = defaultDBName) -> FMDatabase? {
        guard let dbDirPath = dbDirectoryPath else { return nil }
        
        // 直接在 Document 里创建 .db 文件，不再创建子文件夹
        let dbPath = dbDirPath.appending("/\(fileName).db")
        print("数据库路径：\(dbPath)")
        return FMDatabase(path: dbPath)
    }
    
    // 删除数据库
    static func deleteDB(_ fileName: String = defaultDBName) {
        guard let dbDirPath = dbDirectoryPath else { return }
        let dbPath = dbDirPath.appending("/\(fileName).db")
        
        if FileManager.default.fileExists(atPath: dbPath) {
            do {
                try FileManager.default.removeItem(atPath: dbPath)
                print("移除\(fileName)成功")
            } catch {
                print("移除\(fileName)失败")
            }
        }
    }
    
    // 获取所有表
    static func getAllTable(_ fileName: String = defaultDBName) -> [String]? {
        guard let db = createDB(fileName) else { return nil }
        var tableNames = [String]()
        
        if db.open() {
            do {
                let set = try db.executeQuery("SELECT name FROM sqlite_master WHERE type='table' ORDER BY name", values: nil)
                while set.next() {
                    if let name = set.string(forColumn: "name") {
                        tableNames.append(name)
                    }
                }
            } catch {
                print("读取表失败")
            }
            db.close()
        }
        return tableNames
    }
    
    // 删除表
    static func deleteDBTables(_ tableNames: [String]?, _ fileName: String = defaultDBName) {
        guard let tables = tableNames, !tables.isEmpty else { return }
        guard let dbDirPath = dbDirectoryPath else { return }
        let dbPath = dbDirPath.appending("/\(fileName).db")
        
        guard let dbQueue = FMDatabaseQueue(path: dbPath) else { return }
        dbQueue.inTransaction { db, rollback in
            for name in tables {
                do {
                    try db.executeUpdate("DROP TABLE IF EXISTS \(name)", values: nil)
                    print("删除表 \(name) 成功")
                } catch {
                    print("删除表 \(name) 失败")
                    rollback.pointee = true
                    return
                }
            }
        }
    }
    
    // 创建表
    static func createTable(_ tableName: String, _ parameter: String, _ fileName: String = defaultDBName) {
        guard !tableName.isEmpty else { return }
        guard let dbDirPath = dbDirectoryPath else { return }
        let dbPath = dbDirPath.appending("/\(fileName).db")
        
        guard let dbQueue = FMDatabaseQueue(path: dbPath) else { return }
        dbQueue.inDatabase { db in
            do {
                try db.executeUpdate("CREATE TABLE IF NOT EXISTS \(tableName) (\(parameter))", values: nil)
                print("创建表 \(tableName) 成功")
            } catch {
                print("创建表失败")
            }
        }
    }
    
    // 获取表字段
    static func getTableFields(_ tableName: String, _ fileName: String = defaultDBName) -> [String]? {
        guard !tableName.isEmpty else { return nil }
        guard let dbDirPath = dbDirectoryPath else { return nil }
        let dbPath = dbDirPath.appending("/\(fileName).db")
        
        var fields = [String]()
        guard let dbQueue = FMDatabaseQueue(path: dbPath) else { return nil }
        dbQueue.inDatabase { db in
            do {
                let set = try db.executeQuery("PRAGMA table_info(\(tableName))", values: nil)
                while set.next() {
                    if let name = set.string(forColumn: "name") {
                        fields.append(name)
                    }
                }
            } catch {
                print("获取字段失败")
            }
        }
        return fields
    }
    
    // MARK: - 增 ✅ 修复完成
    static func saveData(_ tableName: String, _ key_value_dic: Dictionary<String, String>, _ fileName: String = defaultDBName) {
        guard !tableName.isEmpty else { return }
        guard let dbDirPath = dbDirectoryPath else { return }
        let dbPath = dbDirPath.appending("/\(fileName).db")
        
        guard let dbQueue = FMDatabaseQueue(path: dbPath) else { return }
        dbQueue.inTransaction { db, rollback in
            let success = db.executeUpdate("INSERT INTO \(tableName) (name, password) VALUES (:name, :password)", withParameterDictionary: key_value_dic)
            
            if success {
                print("插入成功：\(key_value_dic)")
            } else {
                print("插入失败")
                rollback.pointee = true
            }
        }
    }
    
    // MARK: - 删 ✅ 修复完成
    static func deleteData(_ tableName: String, _ condition: String, _ fileName: String = defaultDBName) {
        guard !tableName.isEmpty, !condition.isEmpty else { return }
        guard let dbDirPath = dbDirectoryPath else { return }
        let dbPath = dbDirPath.appending("/\(fileName).db")
        
        guard let dbQueue = FMDatabaseQueue(path: dbPath) else { return }
        dbQueue.inTransaction { db, rollback in
            let success = db.executeUpdate("DELETE FROM \(tableName) WHERE \(condition)", withArgumentsIn: [])
            if success {
                print("删除成功")
            } else {
                print("删除失败")
                rollback.pointee = true
            }
        }
    }
    
    // MARK: - 改 ✅ 修复完成
    static func changeData(_ tableName: String, _ key_value_dic: Dictionary<String, String>, _ fileName: String = defaultDBName) {
        guard !tableName.isEmpty else { return }
        guard let dbDirPath = dbDirectoryPath else { return }
        let dbPath = dbDirPath.appending("/\(fileName).db")
        
        guard let dbQueue = FMDatabaseQueue(path: dbPath) else { return }
        dbQueue.inTransaction { db, rollback in
            let success = db.executeUpdate("UPDATE \(tableName) SET password=:password WHERE name=:name", withParameterDictionary: key_value_dic)
            if success {
                print("修改成功")
            } else {
                print("修改失败")
                rollback.pointee = true
            }
        }
    }
    
    // MARK: - 查 ✅ 修复完成
    static func getData(_ tableName: String, _ condition: String?, _ fileName: String = defaultDBName) -> [Dictionary<String, String>]? {
        guard !tableName.isEmpty else { return nil }
        guard let dbDirPath = dbDirectoryPath else { return nil }
        let dbPath = dbDirPath.appending("/\(fileName).db")
        
        var result = [[String:String]]()
        guard let dbQueue = FMDatabaseQueue(path: dbPath) else { return nil }
        
        dbQueue.inDatabase { db in
            var set: FMResultSet?
            
            if let condition = condition {
                set = try? db.executeQuery("SELECT * FROM \(tableName) WHERE \(condition)", values: nil)
            } else {
                set = try? db.executeQuery("SELECT * FROM \(tableName)", values: nil)
            }
            
            while set?.next() == true {
                var dic = [String:String]()
                if let name = set?.string(forColumn: "name") {
                    dic["name"] = name
                }
                if let pwd = set?.string(forColumn: "password") {
                    dic["password"] = pwd
                }
                if !dic.isEmpty {
                    result.append(dic)
                }
            }
        }
        
        print("查询数据：\(result)")
        return result
    }
}
