//
//  UserViewModel.swift
//  ODiazExpense
//
//  Created by MacbookMBA8 on 13/06/23.
//

import Foundation
import SQLite3

class UserViewModel{
    func GetUser(id: Int) -> Result{
        var result = Result()
          let context = DB.init()
          let query = "SELECT id,imagen,nombre, apellidoPaterno, apellidoMaterno, fechaNacimiento From Usuario WHERE id = \(id)"
          var statement : OpaquePointer? = nil
          do{
              if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                  
                  result.Object = User(id: 0,
                                       imagen: "",
                                       nombre: "",
                                       apellidoPaterno: "",
                                       apellidoMaterno: "",
                                       fechaNacimiento: "",
                                       email: "",
                                       password: "")
                  while sqlite3_step(statement) == SQLITE_ROW{
                      var user = User(id: 0,
                                      imagen: "",
                                      nombre: "",
                                      apellidoPaterno: "",
                                      apellidoMaterno: "",
                                      fechaNacimiento: "",
                                      email: "",
                                      password: "")
                      user.id = Int(sqlite3_column_int(statement, 0))
                      user.imagen = String(cString: sqlite3_column_text(statement, 1))
                      user.nombre = String(cString: sqlite3_column_text(statement, 2))
                      user.apellidoPaterno = String(cString: sqlite3_column_text(statement, 3))
                      user.apellidoMaterno = String(cString: sqlite3_column_text(statement, 4))
                      user.fechaNacimiento = String(cString: sqlite3_column_text(statement, 5))
                      
                      result.Object = user
                  }
                  result.Correct = true
              }
          }catch let error{
              result.Correct = false
              result.Ex = error
              result.ErrorMessage = error.localizedDescription
          }
          return result
    }
    
}
