import Foundation
import SQLite3

class LogInViewModel{
    func Add(usuario: User) -> Result{
        var result = Result()
        let context = DB.init()
        let query = "INSERT INTO Usuario (imagen,nombre,apellidoPaterno, apellidoMaterno, fechaNacimiento,correo,password)VALUES(?,?,?,?,?,?,?)"

        var statement : OpaquePointer? = nil
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{

                sqlite3_bind_text(statement, 1, (usuario.imagen as NSString).utf8String, -1, nil)
                sqlite3_bind_text(statement, 2, (usuario.nombre as NSString).utf8String, -1, nil)
                sqlite3_bind_text(statement, 3, (usuario.apellidoPaterno as NSString).utf8String, -1, nil)
                sqlite3_bind_text(statement, 4, (usuario.apellidoMaterno as NSString).utf8String, -1, nil)
                sqlite3_bind_text(statement, 5, (usuario.fechaNacimiento as NSString).utf8String, -1, nil)
                //sqlite3_bind_double(statement, 2, usuario.fechaNacimiento.timeIntervalSinceReferenceDate)
                sqlite3_bind_text(statement, 6, (usuario.email as NSString).utf8String, -1, nil)
                sqlite3_bind_text(statement, 7, (usuario.password as NSString).utf8String, -1, nil)
                

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
    
    func LogIn(email:String, password: String) -> Result{
        var result = Result()
          let context = DB.init()
          let query = "SELECT id,imagen,nombre, apellidoPaterno, apellidoMaterno, fechaNacimiento From Usuario WHERE id ="
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
