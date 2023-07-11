//
//  SubCategory.swift
//  ODiazExpense
//
//  Created by MacbookMBA8 on 12/06/23.
//

import Foundation

struct SubCategory{
    var Id: Int
    var Nombre: String
    var Imagen: String
    var IdCategory: Int
    
    init(Id: Int, Nombre: String, Imagen: String, IdCategory: Int) {
        self.Id = Id
        self.Nombre = Nombre
        self.Imagen = Imagen
        self.IdCategory = IdCategory
    }
    
    init() {
        self.Id = 0
        self.Nombre = ""
        self.Imagen = ""
        self.IdCategory = 0
    }
    
}
