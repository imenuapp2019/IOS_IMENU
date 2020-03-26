//
//  Dish.swift
//  imenu_ios
//
//  Created by Eduardo Antonio Terrero Cabrera on 21/01/2020.
//  Copyright © 2020 Miguel Jaimes. All rights reserved.
//

import Foundation

class Plato: Codable {
    let id: Int?
    let nombre: String?
    let precio: Double?
    let imagenes: [Imagene]?
    let alergenos: [Alergeno]?

    init(id: Int?, nombre: String?, precio: Double?, imagenes: [Imagene]?, alergenos: [Alergeno]?) {
        self.id = id
        self.nombre = nombre
        self.precio = precio
        self.imagenes = imagenes
        self.alergenos = alergenos
    }
}
