//
//  DB.swift
//  ODiazExpense
//
//  Created by MacbookMBA8 on 12/06/23.
//

import Foundation
import SQLite3

class DB{
    let path : String = "ODiazExpense.sql"
    var db : OpaquePointer? = nil
    
    init(){
        db = OpenConexion()
    }
    
    func OpenConexion() -> OpaquePointer? {
        let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathExtension(self.path)
        var db : OpaquePointer? = nil
        
        if sqlite3_open(filePath.path, &db)  == SQLITE_OK{
//            print(filePath)
//            print("Conecxion correcta")
            return db
        }else{
            print("Error")
            return nil
        }
    }
}
