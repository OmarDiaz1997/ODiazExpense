//
//  SubCategoryViewModel.swift
//  ODiazExpense
//
//  Created by MacbookMBA8 on 12/06/23.
//

import Foundation
import SQLite3

class SubCategoryViewModel{
    
    func Add(subCategorie : SubCategory) -> Result{
        var result = Result()
        let context = DB.init()
        let query = "INSERT INTO Subcategorie (nombre, imagen, idCategorie)VALUES(?,?,?)"
        var statement : OpaquePointer? = nil
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                sqlite3_bind_text(statement, 1, (subCategorie.Nombre as NSString).utf8String, -1, nil)
                sqlite3_bind_text(statement, 2, (subCategorie.Imagen as NSString).utf8String, -1, nil)
                sqlite3_bind_int(statement, 3, Int32(subCategorie.IdCategory))
                
                if sqlite3_step(statement) == SQLITE_DONE{
                    result.Correct = true
                }else{
                    result.Correct = false
                }
            }
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        return result
    }
    
    func GetAllByCategory(id: Int) -> Result{
        var result = Result()
          let context = DB.init()
          let query = "SELECT id, nombre, imagen, idCategorie FROM Subcategorie WHERE idCategorie = \(id)"
          var statement : OpaquePointer? = nil
          do{
              if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                  
                  result.Objects = []
                  while sqlite3_step(statement) == SQLITE_ROW{
                      var category = SubCategory()
                      category.Id = Int(sqlite3_column_int(statement, 0))
                      category.Nombre = String(cString: sqlite3_column_text(statement, 1))
                      category.Imagen = String(cString: sqlite3_column_text(statement, 2))
                      category.IdCategory = Int(sqlite3_column_int(statement, 3))
                      
                      result.Objects?.append(category)
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
    
    func GetById(id: Int) -> Result{
        var result = Result()
          let context = DB.init()
          let query = "SELECT id, nombre, imagen,idCategorie FROM Subcategorie WHERE id = \(id)"
          var statement : OpaquePointer? = nil
          do{
              if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                  
                  result.Object = SubCategory()
                  while sqlite3_step(statement) == SQLITE_ROW{
                      var category = SubCategory()
                      category.Id = Int(sqlite3_column_int(statement, 0))
                      category.Nombre = String(cString: sqlite3_column_text(statement, 1))
                      category.Imagen = String(cString: sqlite3_column_text(statement, 2))
                      category.IdCategory = Int(sqlite3_column_int(statement, 3))
                      
                      result.Object = category
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
