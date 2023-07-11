import Foundation
import SQLite3

class CategoryViewModel{
    func Add(categorie : Category) -> Result{
        var result = Result()
        let context = DB.init()
        let query = "INSERT INTO Categorie(Nombre) VALUES(?)"
        var statement : OpaquePointer? = nil
        do{
            if sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                sqlite3_bind_text(statement, 1, (categorie.Nombre as NSString).utf8String, -1, nil)
                
                if sqlite3_step(statement) == SQLITE_DONE{
                    result.Correct = true
                }else{
                    result.Correct = false
                }
            }
        }catch {
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        return result
    }
    
    func GetAll() -> Result{
        var result = Result()
          let context = DB.init()
          let query = "SELECT id, nombre FROM Categorie"
          var statement : OpaquePointer? = nil
          do{
              if sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                  
                  result.Objects = []
                  while sqlite3_step(statement) == SQLITE_ROW{
                      var category = Category(Id: 0, Nombre: "")
                      category.Id = Int(sqlite3_column_int(statement, 0))
                      category.Nombre = String(cString: sqlite3_column_text(statement, 1))
                      
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
    
}
