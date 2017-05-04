//
//  Rerserva.swift
//  Booking App
//
//  Created by user126228 on 1/5/17.
//  Copyright © 2017 user126228. All rights reserved.
//

import Foundation
import UIKit

class Rerserva {
    
    let idreserva:Int
    let idhotel:Int
    let nombre:String
    let fecha:String
    let hab_cantidad:Int
    
    init(idreserva:Int,idhotel:Int,nombre:String,fecha:String,hab_cantidad:Int){
        self.idreserva = idreserva
        self.idhotel = idhotel
        self.nombre = nombre
        self.fecha = fecha
        self.hab_cantidad = hab_cantidad
    }
}
