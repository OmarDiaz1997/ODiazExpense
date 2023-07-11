import Foundation
import SQLite3

class MovimientoViewModel{
    func Add(movimiento : Movimiento) -> Result{
        var result = Result()
        let context = DB.init()
        let query = "INSERT INTO Movimiento (nombre,fecha,monto,tipo,idSubCategorie,idUsuario)VALUES(?,?,?,?,?,?)"
        var statement : OpaquePointer? = nil
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                
                sqlite3_bind_text(statement, 1, (movimiento.nombre as NSString).utf8String, -1, nil)
                sqlite3_bind_double(statement, 2, movimiento.fecha.timeIntervalSinceReferenceDate)
                sqlite3_bind_double(statement, 3, movimiento.monto)
                sqlite3_bind_int(statement, 4, Int32(movimiento.tipo))
                sqlite3_bind_int(statement, 5, Int32(movimiento.idSubCategoria))
                sqlite3_bind_int(statement, 6, Int32(movimiento.idUsuario))
                
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
    
    func GetAllByUser(idUser: Int) -> Result{
        var result = Result()
          let context = DB.init()
          let query = "SELECT id, nombre, fecha, monto,tipo,idSubCategorie FROM Movimiento WHERE idUsuario = \(idUser)"
          var statement : OpaquePointer? = nil
          do{
              if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                  
                  result.Objects = []
                  while sqlite3_step(statement) == SQLITE_ROW{
                      
                      var movimiento = Movimiento()
                      
                      movimiento.id = Int(sqlite3_column_int(statement, 0))
                      movimiento.nombre = String(cString: sqlite3_column_text(statement, 1))
                      //movimiento.fecha = Date()
                      movimiento.monto = Double(sqlite3_column_double(statement, 3))
                      movimiento.tipo = Int(sqlite3_column_int(statement, 4))
                      movimiento.idSubCategoria = Int(sqlite3_column_int(statement, 5))
                      
                      result.Objects?.append(movimiento)
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
