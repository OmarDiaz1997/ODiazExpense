//
//  Movimiento.swift
//  ODiazExpense
//
//  Created by MacbookMBA8 on 14/06/23.
//

import Foundation

struct Movimiento{
    var id: Int
    var nombre: String
    var fecha: Date
    var monto: Double
    var tipo: Int
    var idSubCategoria: Int
    var idUsuario: Int
    
    init(id: Int, nombre: String, fecha: Date, monto: Double, tipo: Int, idSubCategoria: Int, idUsuario: Int) {
        self.id = id
        self.nombre = nombre
        self.fecha = fecha
        self.monto = monto
        self.tipo = tipo
        self.idSubCategoria = idSubCategoria
        self.idUsuario = idUsuario
    }
    
    init() {
        self.id = 0
        self.nombre = ""
        self.fecha = Date()
        self.monto = 0.0
        self.tipo = 0
        self.idSubCategoria = 0
        self.idUsuario = 0
    }
}
