//
//  Reserva.swift
//  Booking App
//
//  Created by user126228 on 1/5/17.
//  Copyright © 2017 user126228. All rights reserved.
//

class Reserva {
    
    let idReserva:Int
    let idHotel:Int
    let nombre:String
    let fecha:String
    let hab_cantidad:Int

    
    init(idReserva:Int,idHotel:Int,nombre:String,fecha:String,hab_cantidad:Int){
        self.idReserva = idReserva
        self.idHotel = idHotel
        self.nombre = nombre
        self.fecha = fecha
        self.hab_cantidad = hab_cantidad
        
    }
}
